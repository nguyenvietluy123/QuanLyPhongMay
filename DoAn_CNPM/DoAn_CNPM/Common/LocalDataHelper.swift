//
//  LocalDataHelper.swift
//  HMKFieldCollector
//
//  Created by Hoa on 11/23/18.
//  Copyright © 2018 Hoa. All rights reserved.
//

import UIKit

class LocalDataHelper: NSObject {
    static let shared = LocalDataHelper()
    
    var roomWasBook: [RoomBookingObj] = []
    var deviceWasBook: [DeviceBookingObj] = []
    
    override init() {
        super.init()
    }
}

let localDataShared = LocalDataHelper.shared

