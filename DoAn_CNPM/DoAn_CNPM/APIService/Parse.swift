//
//  Parse.swift
//  DoAn_CNPM
//
//  Created by Luy Nguyen on 1/1/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import SwiftyJSON

class Parse: NSObject {
    static let shared = Parse()
    override init() {
        super.init()
    }
    
    func parseListUsers(data: JSON) -> [UserId] {
        var items: [UserId] = []
        for json in data.arrayValue {
            let item = UserId(data: json)
            items.append(item)
        }
        return items
    }
    
    func parseListRooms(data: JSON) -> [RoomObj] {
        var items: [RoomObj] = []
        for json in data.arrayValue {
            let item = RoomObj(data: json)
            items.append(item)
        }
        return items
    }
    
    func parseListPCs(data: JSON) -> [DeviceObj] {
        var items: [DeviceObj] = []
        for json in data.arrayValue {
            let item = DeviceObj(data: json)
            items.append(item)
        }
        return items
    }
    
    func parseListLessons(data: JSON) -> [LessonObj] {
        var items: [LessonObj] = []
        for json in data.arrayValue {
            let item = LessonObj(data: json)
            items.append(item)
        }
        return items
    }
    
    func parseListRoomBooking(data: JSON) -> [RoomBookingObj] {
        var items: [RoomBookingObj] = []
        for json in data.arrayValue {
            let item = RoomBookingObj(data: json)
            items.append(item)
        }
        return items
    }
    
    func parseListDeviceBooking(data: JSON) -> [DeviceBookingObj] {
        var items: [DeviceBookingObj] = []
        for json in data.arrayValue {
            let item = DeviceBookingObj(data: json)
            items.append(item)
        }
        return items
    }
    
}

let parseShared = Parse.shared
