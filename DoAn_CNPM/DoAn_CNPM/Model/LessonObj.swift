//
//  LessonObj.swift
//  DoAn_CNPM
//
//  Created by Luy Nguyen on 1/1/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON

class LessonObj: NSObject {
    var id: Int = 0
    var lname: String = ""
    var ltime: String = ""
    
    var choose: rStatus = .unSelect
    var itsMe: Bool = false
    
    override init() {
        super.init()
    }
    
    init(data: JSON) {
        self.id = data["id"].intValue
        self.lname = data["lname"].stringValue
        self.ltime = data["ltime"].stringValue
    }
}
