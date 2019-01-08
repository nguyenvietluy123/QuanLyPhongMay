//
//  Video.swift
//  Youtube
//
//  Created by Luy Nguyen on 10/30/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON
class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        let uppercasedFirstCharacter = String(key.description.first!).uppercased()
        let range = key.startIndex...key.startIndex
        let selectorString = key.replacingCharacters(in: range, with: uppercasedFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let response = self.responds(to: selector)
        
        if !response {
            return
        }
        
        super.setValue(value, forKey: key)
    }
}

class DateObj: SafeJsonObject {
    @objc var phong_id: String?
    @objc var name: String?
    @objc var may: String?
    @objc var tiet: String?
    @objc var statusp: String?
    

//    @objc var channel: Channel?

    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "channel" {
//            self.channel = Channel()
//            self.channel?.setValuesForKeys(value as! [String : AnyObject] )
//        } else {
            super.setValue(value, forKey: key)
//        }
    }

    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}

//class Channel: SafeJsonObject {
//    @objc var name: String?
//    @objc var profile_image_name: String?
//}
