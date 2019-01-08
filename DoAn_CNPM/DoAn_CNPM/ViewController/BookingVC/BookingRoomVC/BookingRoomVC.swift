//
//  BookingRoomVC.swift
//  QuanLyPhongMay
//
//  Created by Luy Nguyen on 12/4/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//

import UIKit

class BookingRoomVC: BaseVC {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var tableView: UITableView!
    
    var userId: UserId = UserId()
    var arrRoom: [RoomObj] = []
    var arrPCs: [DeviceObj] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        initData()
    }


}


extension BookingRoomVC {
    func initUI() {
        navi.handleBack = {
            self.clickBack()
        }
        
        tableView.register(RoomCell.self)
    }
    
    func initData() {
        fetch_PCs()
        fetch_Rooms()
    }
    
    func fetch_PCs() {
        apiServiceShared.fetch_PCs { (arrPCs) in
            self.arrPCs = arrPCs
            self.tableView.reloadData()
        }
    }
    
    func fetch_Rooms() {
        self.arrRoom.removeAll()
        apiServiceShared.fetch_Rooms { (arrRoom) in
            self.arrRoom.append(contentsOf: arrRoom)
            self.check_roomWasBook()
            self.tableView.reloadData()
        }
    }
    
    func check_roomWasBook() {
        for i in localDataShared.roomWasBook.indices {
            if localDataShared.roomWasBook[i].bookdate == mainUser.bookdate {
                for y in arrRoom.indices {
                    if localDataShared.roomWasBook[i].rid ==  arrRoom[y].id {
                        arrRoom[y].status = .Booked
                        if localDataShared.roomWasBook[i].uid == mainUser.uid {
                            arrRoom[y].itsMe = true
                        }
                    }
                }
            }
        }
        
    }
    
    func fetch_MasterData() {
        localDataShared.roomWasBook.removeAll()
        if mainUser.role == .GV {
            apiServiceShared.fetch_RoomWasBook { (arrRoomBooking) in
                localDataShared.roomWasBook.append(contentsOf: arrRoomBooking)
//                for i in arrRoomBooking.indices {
//                    if arrRoomBooking[i].uid == mainUser.uid {
//                        localDataShared.roomWasBook.append(arrRoomBooking[i])
//                    }
//                }
                self.fetch_Rooms()
            }
        }
    }
}

extension BookingRoomVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRoom.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as RoomCell
        cell.config(arrRoom[indexPath.item])
        cell.lbNumPC.text = " id: \(arrRoom[indexPath.item].id) \n \(checkPCs(indexPath.item).0)/\(checkPCs(indexPath.item).1)" + " máy hỏng"
        return cell
    }
    
    func checkPCs(_ index: Int) -> (Int, Int) {
        var count = 0
        var totalCount = 0
        
        for i in arrPCs.indices {
            if arrPCs[i].rid == arrRoom[index].id {
                totalCount += 1
                if arrPCs[i].dstatus == .fail {
                    count += 1
                }
            }
        }
        
        return (count, totalCount)
    }
}

extension BookingRoomVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if arrRoom[indexPath.item].status == .Booked {
            if mainUser.role == .SV {
                var arrTietGVBook: [String] = []
                for i in localDataShared.roomWasBook.indices {
                    if localDataShared.roomWasBook[i].bookdate == mainUser.bookdate {
                        if localDataShared.roomWasBook[i].rid == arrRoom[indexPath.item].id {
                            arrTietGVBook.append(localDataShared.roomWasBook[i].lname)
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
                Common.showAlert("Phòng đã được giảng viên đặt tiết \(str) vào ngày \(Common.convertDateFormater(mainUser.bookdate)). Sinh viên không được sử dụng cho đến khi giảng viên trả phòng. Vui lòng thử lại")
                return
            }
        }
        
        
        //chỗ này của giáo viên
        let vc = BookingPCVC(nibName: "BookingPCVC", bundle: nil)
        vc.rStatus = arrRoom[indexPath.item].status
        vc.roomName = arrRoom[indexPath.item].rname
        mainUser.rid = arrRoom[indexPath.item].id
        vc.handleReload = {
            self.fetch_MasterData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
//        ApiService.ShareInstance.fetch_Room(userId: userId) { (arrRoom) in
//            let vc = BookingPCVC(nibName: "BookingPCVC", bundle: nil)
//            self.userId.tenPhong = arrData[indexPath.item].name ?? ""
//            vc.statusBooking = arrData[indexPath.item].statusp == "3" ? "Cancel >>" : "Booking >>"
//            vc.arrRoom = arrRoom
//            vc.userId = self.userId
//            self.navigationController?.pushViewController(vc, animated: true)
//        }

    }

    

}


