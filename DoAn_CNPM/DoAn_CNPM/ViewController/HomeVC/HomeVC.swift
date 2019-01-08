//
//  HomeVC.swift
//  CNPM
//
//  Created by Luy Nguyen on 12/1/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//

import UIKit

class HomeVC: BaseVC {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var tableView: UITableView!
    
    var arrRoom: [RoomBookingObj] = []
    var arrDevice: [DeviceBookingObj] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeVC {
    func initUI() {
        navi.handleMenu = {
            self.clickMenu()
        }
        self.tableView.backgroundView = Common.viewNoData()
        tableView.register(CellHome.self)
    }
    
    func initData() {
        fetch_MasterData()
    }
    
    func fetch_MasterData() {
        localDataShared.roomWasBook.removeAll()
        localDataShared.deviceWasBook.removeAll()
        if mainUser.role == .GV {
            apiServiceShared.fetch_RoomWasBook { (arrRoomBooking) in
                
                for i in arrRoomBooking.indices {
                    if arrRoomBooking[i].uid == mainUser.uid {
                        if self.isDateValid(arrRoomBooking[i].bookdate) {
                            localDataShared.roomWasBook.append(arrRoomBooking[i])
                        }
                    }
                    
                }
                
                self.arrRoom = localDataShared.roomWasBook.sorted {$0.bookdate.localizedStandardCompare($1.bookdate) == .orderedAscending}
                
                self.arrRoom = self.arrRoom.sorted(by: { (s1, s2) -> Bool in
                    if s1.bookdate == s2.bookdate {
                        return s1.rname < s2.rname
                    }
                    return false
                })
                
                self.arrRoom = self.arrRoom.sorted(by: { (s1, s2) -> Bool in
                    if s1.bookdate == s2.bookdate {
                        if s1.rname == s2.rname {
                            return s1.lname < s2.lname
                        } else {
                            return false
                        }
                    }
                    return false
                })
                
                self.tableView.backgroundView = self.arrRoom.count > 0 ? nil : Common.viewNoData()
                self.tableView.reloadData()
            }
        } else {
            apiServiceShared.fetch_DeviceWasBook { (arrDeviceBooking) in
                
                for i in arrDeviceBooking.indices {
                    if arrDeviceBooking[i].uid == mainUser.uid {
                        if self.isDateValid(arrDeviceBooking[i].bookdate) {
                            localDataShared.deviceWasBook.append(arrDeviceBooking[i])
                        }
                    }
                }
                
                self.arrDevice = localDataShared.deviceWasBook.sorted {$0.bookdate.localizedStandardCompare($1.bookdate) == .orderedAscending}
                
                self.arrDevice = self.arrDevice.sorted(by: { (s1, s2) -> Bool in
                    if s1.bookdate == s2.bookdate {
                        return s1.lname < s2.lname
                    }
                    return false
                })
                
                self.tableView.backgroundView = self.arrDevice.count > 0 ? nil : Common.viewNoData()
                self.tableView.reloadData()
            }
        }
    }
    
    func isDateValid(_ date: String) -> Bool {
        if Date.init(string: date).endDate.secondsSince1970 < Double(Date().secondsSince1970) {
            return false
        }
        return true
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainUser.role == .GV ? localDataShared.roomWasBook.count : localDataShared.deviceWasBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellHome
        cell.lbContent.text = "Bạn đã đặt \(mainUser.role == .GV ? "phòng" : "máy" )"
        
        if mainUser.role == .GV {
            cell.lbContent.text = "Bạn đã đặt phòng \(arrRoom[indexPath.item].rname), \(arrRoom[indexPath.item].lname), ngày \(Common.convertDateFormater(arrRoom[indexPath.item].bookdate))"
        } else {
            cell.lbContent.text = "Bạn đã đặt \(arrDevice[indexPath.item].lname) máy \(arrDevice[indexPath.item].dname), ngày \(Common.convertDateFormater(arrDevice[indexPath.item].bookdate))"
        }
        return cell
    }

}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

