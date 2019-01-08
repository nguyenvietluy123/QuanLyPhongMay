//
//  PCObj.swift
//  QuanLyPhongMay
//
//  Created by Luy Nguyen on 12/10/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//
import UIKit
import SwiftyJSON

class DeviceBookingObj: NSObject {
    var id: Int = 0
    var did: Int = 0
    var lid: Int = 0
    var uid: Int = 0
    var bookdate: String = ""
    var dname: String = ""
    var rname: String = ""
    var lname: String = ""
    var fullname: String = ""
    var rid: Int = 0
    
    override init() {
        super.init()
    }
    
    init(data: JSON) {
        self.id = data["id"].intValue
        self.did = data["did"].intValue
        self.lid = data["lid"].intValue
        self.uid = data["uid"].intValue
        self.bookdate = data["bookdate"].stringValue
        self.dname = data["dname"].stringValue
        self.rname = data["rname"].stringValue
        self.lname = data["lname"].stringValue
        self.fullname = data["fullname"].stringValue
        self.rid = data["rid"].intValue
    }
}
