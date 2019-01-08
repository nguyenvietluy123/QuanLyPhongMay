//
//  FilterEmployeeVC.swift
//  HMKFieldCollector
//
//  Created by Luy Nguyen on 11/26/18.
//  Copyright © 2018 Hoa. All rights reserved.
//

import UIKit

class BookingPeriodVC: BaseVC {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewConfirm: KHView!
    
    var role: Role = .SV
    var arrLid: [Int] = []
    var arrLessons: [LessonObj] = []
    var handleReload: (() -> ())?
    var deviceName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    
    @IBAction func actionConfirm(_ sender: Any) {
        AlertController.present(style: .alert, title: "Thông báo", message: "Bạn có muốn đặt tiết này?", actionTitles: ["Huỷ", "Đồng ý"], handler: { (action) in
            if action.title == "Huỷ" {
                return
            } else {
                
                switch self.role {
                case .SV:
                    apiServiceShared.book_Device(user: mainUser, success: { (response) in
                        if response {
                            Common.showAlert("Bạn đã đặt tiết thành công")
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    })
                    break
                case .GV:
                    for i in self.arrLid.indices {
                        mainUser.lid = self.arrLid[i]
                        apiServiceShared.book_Room(user: mainUser, success: { (response) in
                            if response {
                                if self.arrLid.count - 1 == i {
                                    Common.showAlert("Bạn đã đặt phòng thành công")
                                    self.navigationController?.popToRootViewController(animated: true)
                                }
                                
                            }
                        })
                    }
                    break
                }
            }
        })
    }
}

extension BookingPeriodVC {
    func initUI() {
        navi.title = deviceName
//        navi.hasRight = false
        viewConfirm.isHidden = true
        
        navi.handleBack = {
            self.clickBack()
        }
        
//        navi.handleCheckDone = {
//            AlertController.present(style: .alert, title: "Thông báo", message: "Bạn có muốn đặt tiết này?", actionTitles: ["Huỷ", "Đồng ý"], handler: { (action) in
//                if action.title == "Huỷ" {
//                    return
//                } else {
//
//                    switch self.role {
//                    case .SV:
//                        apiServiceShared.book_Device(user: mainUser, success: { (response) in
//                            if response {
//                                Common.showAlert("Bạn đã đặt tiết thành công")
//                                self.navigationController?.popToRootViewController(animated: true)
//                            }
//                        })
//                        break
//                    case .GV:
//                        for i in self.arrLid.indices {
//                            mainUser.lid = self.arrLid[i]
//                            apiServiceShared.book_Room(user: mainUser, success: { (response) in
//                                if response {
//                                    if self.arrLid.count - 1 == i {
//                                        Common.showAlert("Bạn đã đặt phòng thành công")
//                                        self.navigationController?.popToRootViewController(animated: true)
//                                    }
//
//                                }
//                            })
//                        }
//
//                        break
//                    }
//
//
//                }
//            })
//        }
        
        tableView.register(CellLesson.self)
    }
    
    func initData() {
        fetchLessons()
    }
    
    func fetchLessons() {
        self.arrLessons.removeAll()
        apiServiceShared.fetch_Lessons { (arrLessons) in
            self.arrLessons.append(contentsOf: arrLessons)
            if self.role == .GV {
                self.check_roomWasBook()
            } else {
                self.check_deviceWasBook()
            }
            self.tableView.reloadData()
        }
    }
    
    func check_roomWasBook() {
        for i in localDataShared.roomWasBook.indices {
            //            if localDataShared.roomWasBook[i].uid == mainUser.uid {
            if localDataShared.roomWasBook[i].bookdate == mainUser.bookdate {
                if localDataShared.roomWasBook[i].rid == mainUser.rid {
                    for y in arrLessons.indices {
                        if localDataShared.roomWasBook[i].lid ==  arrLessons[y].id {
                            arrLessons[y].choose = .Booked
                            if localDataShared.roomWasBook[i].uid == mainUser.uid {
                                arrLessons[y].itsMe = true
                            }
                        }
                    }
                }
            }
            //            }
        }
    }
    
    func check_deviceWasBook() {
        for i in localDataShared.deviceWasBook.indices {
            //            if localDataShared.deviceWasBook[i].uid == mainUser.uid {
            if localDataShared.deviceWasBook[i].bookdate == mainUser.bookdate {
                if localDataShared.deviceWasBook[i].rid == mainUser.rid {
                    if localDataShared.deviceWasBook[i].did == mainUser.did {
                        
                        for y in arrLessons.indices {
                            if localDataShared.deviceWasBook[i].lid ==  arrLessons[y].id {
                                arrLessons[y].choose = .Booked
                                if localDataShared.deviceWasBook[i].uid == mainUser.uid {
                                    arrLessons[y].itsMe = true
                                }
                            }
                        }
                    }
                }
            }
            //            }
        }
    }
    
    func fetch_MasterData() {
        localDataShared.roomWasBook.removeAll()
        
        apiServiceShared.fetch_RoomWasBook { (arrRoomBooking) in
            localDataShared.roomWasBook.append(contentsOf: arrRoomBooking)
            self.initData()
        }
    }
}

extension BookingPeriodVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellLesson
        cell.configCell(arrLessons[indexPath.item])
        return cell
    }
}

extension BookingPeriodVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        viewConfirm.isHidden = arrLessons[indexPath.item].choose == .Booked ? true : false
//        navi.hasRight = arrLessons[indexPath.item].choose == .Booked ? false : true
        
        mainUser.lid = arrLessons[indexPath.item].id
        
        if role == .SV {
            if arrLessons[indexPath.item].choose == .Booked {
                if arrLessons[indexPath.item].itsMe {
                    let deviceBookingObj = getIDCancel(indexPath.item)
                    
                    AlertController.present(style: .alert, title: "Thông báo", message: "Bạn có muốn huỷ \(deviceBookingObj.lname), \(deviceBookingObj.dname), \(Common.convertDateFormater(deviceBookingObj.bookdate))", actionTitles: ["Huỷ", "Đồng ý"], handler: { (action) in
                        if action.title == "Huỷ" {
                            return
                        } else {
                            apiServiceShared.cancel_Device(id: deviceBookingObj.id, success: { (response) in
                                if response {
                                    Common.showAlert("Bạn đã huỷ tiết thành công")
                                    self.navigationController?.popToRootViewController(animated: true)
                                }
                            })
                        }
                    })
                } else {
                    Common.showAlert("Bạn không thể huỷ tiết của người khác.")
                }
                
            } else {
                for i in arrLessons.indices {
                    if arrLessons[i].choose == .Booked {
                        continue
                    }
                    if indexPath.item == i {
                        arrLessons[i].choose = .Select
                    } else {
                        arrLessons[i].choose = .unSelect
                    }
                }
                tableView.reloadData()
            }
        }
        
        if role == .GV {
            if arrLessons[indexPath.item].choose == .Booked {
                if arrLessons[indexPath.item].itsMe {
                    AlertController.present(style: .alert, title: "Thông báo", message: "Bạn có muốn huỷ \(arrLessons[indexPath.item].lname)", actionTitles: ["Huỷ", "Đồng ý"], handler: { (action) in
                        if action.title == "Huỷ" {
                            return
                        } else {
                            let roomWasBookObj = self.getIDRoomCancel(indexPath.item)
                            apiServiceShared.cancel_Room(id: roomWasBookObj.id, success: { (response) in
                                Common.showAlert("Bạn đã huỷ tiết thành công")
                                self.fetch_MasterData()
                                self.handleReload?()
                            })
                        }
                    })
                } else {
                    Common.showAlert("Bạn không thể huỷ tiết của người khác.")
                }
            } else if arrLessons[indexPath.item].choose == .Select {
                arrLessons[indexPath.item].choose = .unSelect
                arrLid.remove(object: arrLessons[indexPath.item].id)
            } else if arrLessons[indexPath.item].choose == .unSelect {
                arrLessons[indexPath.item].choose = .Select
                arrLid.append(arrLessons[indexPath.item].id)
            }
            
            viewConfirm.isHidden = arrLid.count == 0
//            navi.hasRight = arrLid.count != 0
            tableView.reloadData()
        }
    }
    
    func getIDRoomCancel(_ index: Int) -> RoomBookingObj {
        for i in localDataShared.roomWasBook.indices {
            if localDataShared.roomWasBook[i].uid == mainUser.uid {
                if localDataShared.roomWasBook[i].bookdate == mainUser.bookdate {
                    if localDataShared.roomWasBook[i].rid == mainUser.rid {
                        if localDataShared.roomWasBook[i].lid == arrLessons[index].id {
                            return localDataShared.roomWasBook[i]
                        }
                    }
                }
            }
        }
         return RoomBookingObj()
    }
    
    func getIDCancel(_ index: Int) -> DeviceBookingObj {
        for i in localDataShared.deviceWasBook.indices {
            if localDataShared.deviceWasBook[i].uid == mainUser.uid {
                if localDataShared.deviceWasBook[i].bookdate == mainUser.bookdate {
                    if localDataShared.deviceWasBook[i].rid == mainUser.rid {
                        if localDataShared.deviceWasBook[i].did == mainUser.did {
                            if localDataShared.deviceWasBook[i].lid == arrLessons[index].id {
                                return localDataShared.deviceWasBook[i]
                            }
                        }
                    }
                }
            }
        }
        return DeviceBookingObj()
    }
}

extension Array where Element: Equatable {
    
    @discardableResult mutating func remove(object: Element) -> Bool {
        if let index = index(of: object) {
            self.remove(at: index)
            return true
        }
        return false
    }
    
    @discardableResult mutating func remove(where predicate: (Array.Iterator.Element) -> Bool) -> Bool {
        if let index = self.index(where: { (element) -> Bool in
            return predicate(element)
        }) {
            self.remove(at: index)
            return true
        }
        return false
    }
    
}
