//
//  RoomObj.swift
//  QuanLyPhongMay
//
//  Created by Luy Nguyen on 12/10/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//
import UIKit
import SwiftyJSON

class RoomBookingObj: NSObject {
    var id: Int = 0
    var rid: Int = 0
    var lid: Int = 0
    var uid: Int = 0
    var bookdate: String = ""
    var rname: String = ""
    var lname: String = ""
    var fullname: String = ""
    
    override init() {
        super.init()
    }
    
    init(data: JSON) {
        self.id = data["id"].intValue
        self.rid = data["rid"].intValue
        self.lid = data["lid"].intValue
        self.uid = data["uid"].intValue
        self.bookdate = data["bookdate"].stringValue
        self.rname = data["rname"].stringValue
        self.lname = data["lname"].stringValue
        self.fullname = data["fullname"].stringValue
    }
}
