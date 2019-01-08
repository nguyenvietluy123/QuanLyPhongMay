//
//  BookingPCVC.swift
//  QuanLyPhongMay
//
//  Created by Luy Nguyen on 12/4/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//

import UIKit

class BookingPCVC: BaseVC {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewBookRoom: UIView!
    @IBOutlet weak var viewCancel: UIView!
    @IBOutlet weak var lbBooking: KHLabel!
    
    var userId: UserId = UserId()
    var arrPCs: [DeviceObj] = []
    var arrLessons: [LessonObj] = []
    var arrStringLessons: [String] = []
    var rStatus: rStatus = .Booked
    var roomName = ""
    var handleReload: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        initData()
    }
    
    @IBAction func bookRoom(_ sender: Any) {
        let vc = BookingPeriodVC(nibName: "BookingPeriodVC", bundle: nil)
        vc.role = mainUser.role
        vc.deviceName = "Đặt tiết"
        vc.handleReload = {
            self.handleReload?()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func cancelRoom(_ sender: Any) {
        var arrId: [Int] = []
        for i in localDataShared.roomWasBook.indices {
            if localDataShared.roomWasBook[i].uid == mainUser.id {
                if localDataShared.roomWasBook[i].bookdate == mainUser.bookdate {
                    if localDataShared.roomWasBook[i].rid == mainUser.rid {
                        arrId.append(localDataShared.roomWasBook[i].id)
                    }
                }
            }
        }
        
        AlertController.present(style: .alert, title: "Book Room", message: "Bạn có muốn huỷ phòng này", actionTitles: ["Huỷ", "Đồng ý"], handler: { (action) in
            if action.title == "Huỷ" {
                return
            } else {
//                if arrId.count == 0 {
//                    Common.showAlert("Phòng đã được huỷ")
//                    self.navigationController?.popToRootViewController(animated: true)
//                    return
//                }
                
                if arrId.count == 0 {
                    Common.showAlert("bạn chưa đặt tiết nào trong phòng này")
                    return
                }
                
                for i in arrId.indices {
                    apiServiceShared.cancel_Room(id: arrId[i]) { (response) in
                        if response {
                            
                            if i == arrId.count - 1 {
                                Common.showAlert("Bạn đã huỷ phòng thành công")
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                        }
                    }
                }
            }
        })
    }
    
    func showActionSheetStringPicker(arrStr: [String], sender: UIButton) {
        
        ActionSheetStringPicker.show(withTitle: "Chọn tiết đặt phòng", rows: arrStr, initialSelection: 0, doneBlock: { (picker, index, value) in
            
            mainUser.lid = self.arrLessons[index].id
            
            AlertController.present(style: .alert, title: "Book Room", message: "Bạn có muốn đặt phòng này", actionTitles: ["Huỷ", "Đồng ý"], handler: { (action) in
                if action.title == "Huỷ" {
                    return
                } else {
                    apiServiceShared.book_Room(user: mainUser, success: { (response) in
                        if response {
                            Common.showAlert("Bạn đã đặt phòng thành công")
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    })
                    
                }
            })
        }, cancel: { (picker) in
        }, origin: sender)
    }
}

extension BookingPCVC {
    func initUI() {
        viewBookRoom.isHidden = mainUser.role == .GV ? false : true
        viewCancel.isHidden = rStatus == .Booked ? false : true
        
        navi.title = roomName
        navi.handleBack = {
            self.clickBack()
        }
        
        collectionView.register(CellPC.self)
    }
    
    func initData() {
        fetch_PCs()
        fetchLessons()
    }
    
    func fetch_PCs() {
        apiServiceShared.fetch_PCs { (arrPCs) in
            for i in arrPCs.indices {
                if arrPCs[i].rid == mainUser.rid {
                    self.arrPCs.append(arrPCs[i])
                }
            }
            self.check_deviceWasBook()
            self.collectionView.reloadData()
        }
    }
    
    func fetchLessons() {
        apiServiceShared.fetch_Lessons { (arrLessons) in
            self.arrLessons.append(contentsOf: arrLessons)
            
            self.arrStringLessons.append(contentsOf: self.arrLessons.map({ (lesson) -> String in
                lesson.lname + " " + lesson.ltime
            }))
        }
    }
    
    func check_deviceWasBook() {
        for i in localDataShared.deviceWasBook.indices {
            if localDataShared.deviceWasBook[i].bookdate == mainUser.bookdate {
                if localDataShared.deviceWasBook[i].rid == mainUser.rid {
                    for y in arrPCs.indices {
                        if localDataShared.deviceWasBook[i].did ==  arrPCs[y].id {
                            arrPCs[y].dstatus = .booked
                        }
                    }
                }
            }
        }
    }
}

extension BookingPCVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CellPC
        cell.config(arrPCs[indexPath.item])
        
//        if arrRoom[indexPath.item].statusm == "4"{
//            cell.isUserInteractionEnabled = false
//        }
        
        return cell
    }
}

extension BookingPCVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         if mainUser.role == .GV {
            if arrPCs[indexPath.item].dstatus == .booked {
                var arrTietGVBook: [String] = []
                for i in localDataShared.deviceWasBook.indices {
                    if localDataShared.deviceWasBook[i].bookdate == mainUser.bookdate {
                        if localDataShared.deviceWasBook[i].rid == arrPCs[indexPath.item].rid {
                            if localDataShared.deviceWasBook[i].did == arrPCs[indexPath.item].id {
                                arrTietGVBook.append(localDataShared.deviceWasBook[i].lname)
                            }
                        }
                    }
                }
                arrTietGVBook = arrTietGVBook.sorted {$0.localizedStandardCompare($1) == .orderedAscending}
                var str = ""
                for i in arrTietGVBook.indices {
                    str += arrTietGVBook[i] + ", "
                }
                str.removeLast()
                str.removeLast()
                Common.showAlert("Máy đã được sinh viên đặt \(str) ngày \(Common.convertDateFormater(mainUser.bookdate))")
                return
            } else if arrPCs[indexPath.item].dstatus == .ok {
                Common.showAlert("Máy chưa đăng ký")
            } else if arrPCs[indexPath.item].dstatus == .fail {
                Common.showAlert("Máy hỏng")
            }
            
        }
        
        if mainUser.role == .SV {
            if arrPCs[indexPath.item].dstatus == .fail {
                Common.showAlert("Máy hỏng")
                return
            }
            let vc = BookingPeriodVC(nibName: "BookingPeriodVC", bundle: nil)
            vc.deviceName = arrPCs[indexPath.item].dname
            vc.role = mainUser.role
            mainUser.did = arrPCs[indexPath.item].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension BookingPCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAt indexPath:IndexPath) -> CGSize {
        let cellSize:CGSize = CGSize.init(width: (ScreenSize.SCREEN_WIDTH)/4 - 10, height: (ScreenSize.SCREEN_WIDTH)/4 - 10)
        return cellSize
    }

}
