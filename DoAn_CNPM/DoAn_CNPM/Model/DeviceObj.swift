//
//  PCObj.swift
//  QuanLyPhongMay
//
//  Created by Luy Nguyen on 12/10/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//
import UIKit
import SwiftyJSON

class DeviceObj: NSObject {
    var id: Int = 0
    var dname: String = ""
    var dstatus: dStatus = .ok
    var rid: Int = 0
    
    override init() {
        super.init()
    }
    
    init(data: JSON) {
        self.id = data["id"].intValue
        self.dname = data["dname"].stringValue
        self.dstatus = dStatus(rawValue: data["dstatus"].stringValue) ?? .ok
        self.rid = data["rid"].intValue
    }
}
