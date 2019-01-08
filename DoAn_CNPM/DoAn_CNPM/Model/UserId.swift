//
//  UserId.swift
//  QuanLyPhongMay
//
//  Created by Luy Nguyen on 12/10/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserId: NSObject {
    var id: Int = 0
    var email: String = ""
    var password: String = ""
    var fullname: String = ""
    var role: Role = .GV

    var bookdate: String = ""
    var rid: Int = 0
    var lid: Int = 0
    var did: Int = 0
    var uid: Int = 0
    
    override init() {
        super.init()
    }
    
    init(data: JSON) {
        self.id = data["id"].intValue
        self.email = data["email"].stringValue
        self.password = data["password"].stringValue
        self.fullname = data["fullname"].stringValue
        self.role = Role(rawValue: data["role"].stringValue) ?? .GV
    }
}

