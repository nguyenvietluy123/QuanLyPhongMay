//
//  BookingVC.swift
//  CNPM
//
//  Created by Luy Nguyen on 12/3/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//

import UIKit

var arrData: [DateObj] = []

class BookingVC: BaseVC {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var lbDate: KHTextField!
    
    var arrRoom: [RoomObj] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetch_MasterData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func btnShowPicker(_ sender: Any) {
        showActionSheetDatePicker(title: "Chọn ngày đặt phòng", mode: .date, sender: sender as! UIButton)
    }
    
    var dateSheet: Date = Date()
    func showActionSheetDatePicker(title: String, mode: UIDatePicker.Mode, sender: UIButton){
        ActionSheetDatePicker.show(withTitle: title, datePickerMode: mode, selectedDate: self.dateSheet, doneBlock: { (picker, selectedDate, origin) in
            if let date = selectedDate as? Date {
                if self.isDateValid(date) {
                    self.dateSheet = date
                    mainUser.bookdate = date.string("yyyy-MM-dd")
                    self.lbDate.text = date.string("dd/MM/yyyy")
                }
            }
        }, cancel: { (picker) in
        }, origin: sender)
    }
    
    @IBAction func actionAgree(_ sender: Any) {
        let vc = BookingRoomVC(nibName: "BookingRoomVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func isDateValid(_ date: Date) -> Bool {
        if date.endDate.secondsSince1970 < Double(Date().secondsSince1970) {
            Common.showAlert("Không được chọn ngày trong quá khứ. Vui lòng chọn lại")
            return false
        }
        return true
    }
}

extension BookingVC {
    func initUI() {
        navi.handleMenu = {
            self.clickMenu()
        }
        
        lbDate.text = Date.init(seconds: Date().secondsSince1970).string("dd/MM/yyyy")
        mainUser.bookdate = Date.init(seconds: Date().secondsSince1970).string("yyyy-MM-dd")
    }
    
    func initData() {
        
    }
    
    func fetch_MasterData() {
        localDataShared.roomWasBook.removeAll()
        localDataShared.deviceWasBook.removeAll()
        
        apiServiceShared.fetch_RoomWasBook { (arrRoomBooking) in
            localDataShared.roomWasBook.append(contentsOf: arrRoomBooking)
//            for i in arrRoomBooking.indices {
//                if arrRoomBooking[i].uid == mainUser.uid {
//                    localDataShared.roomWasBook.append(arrRoomBooking[i])
//                }
//            }
        }
        
        apiServiceShared.fetch_DeviceWasBook { (arrDeviceBooking) in
            localDataShared.deviceWasBook.append(contentsOf: arrDeviceBooking)
//            for i in arrDeviceBooking.indices {
//                if arrDeviceBooking[i].uid == mainUser.uid {
//                    localDataShared.deviceWasBook.append(contentsOf: arrDeviceBooking)
//                }
//            }
        }
    }
}
