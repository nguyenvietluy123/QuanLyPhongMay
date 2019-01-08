//
//  RoomObj.swift
//  QuanLyPhongMay
//
//  Created by Luy Nguyen on 12/10/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//
import UIKit
import SwiftyJSON

class RoomObj: NSObject {
    var id: Int = 0
    var rname: String = ""
    
    var status: rStatus = .unSelect
    var itsMe = false
    
    override init() {
        super.init()
    }
    
    init(data: JSON) {
        self.id = data["id"].intValue
        self.rname = data["rname"].stringValue

    }
}
