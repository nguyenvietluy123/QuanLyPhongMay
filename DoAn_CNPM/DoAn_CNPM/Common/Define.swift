//
//  Define.swift
//  Carenefit
//
//  Created by Tony Tuan on 9/4/17.
//  Copyright © 2017 sdc. All rights reserved.
//

import UIKit

let isIPad = DeviceType.IS_IPAD
let heightRatio = (isIPad) ? 1.4 : ScreenSize.SCREEN_HEIGHT/736
let widthRatio = (isIPad) ? 1.4 : ScreenSize.SCREEN_WIDTH/414
let heightDetailCell = (isIPad) ? 55 : 40*heightRatio
let timeZoneApp = 7*60*60
let ctrTopCellDetail = (isIPad) ? 20 : 15*heightRatio
let heightCellContact = (isIPad) ? 60 : 45*heightRatio
let heightTitleCollapse = (isIPad) ? 70 : 50*heightRatio

enum Role: String {
    case GV = "GV"
    case SV = "SV"
}

enum rStatus {
    case Booked
    case Select
    case unSelect
}

enum dStatus: String {
    case ok = "OK"
    case fail = "FAIL"
    case booked = "BOOKED"
}

enum NetworkConnection {
    case available
    case notAvailable
}

class API {
    static let login = "loginmobile"
    static let password = "password"
    static let forgot = "forgot"
    static let validateactivecode = "validateactivecode"
    static let reset = "reset"
    static let logout = "logout"
    static let all = "all"
    static let user = "user"
    static let employees = "employees"
    static let branches = "branches"
    static let tasks = "tasks"
    static let create = "create"
    static let data = "data"
    static let filter = "filter"
    static let funders = "funders"
    static let loans = "loans"
    static let loantypes = "loantypes"
    static let loanbranchlocalitys = "loanbranchlocalitys"
    static let searchTerm = "searchTerm="
    static let status = "status="
    static let fromDate = "fromDate="
    static let toDate = "toDate="
    static let employeeId = "employeeId="
    static let employee = "employee"
    static let registerDate = "registerDate="
    static let location = "location"
    static let edit = "edit"
    static let image = "image"
    static let upload = "upload"
    static let checkin = "checkin"
    static let sections = "sections"
    static let departmentId = "departmentId="
}

enum ErrorCode: String {
    case NoCode
}

enum SaveKey: String {
    case deviceToken = "deviceToken"
    case tokenType = "tokenType"
    case accessToken = "accessToken"
    case email = "email"
    case pass = "pass"
    case isLogin = "isLogin"
}

class NotificationCenterKey {
    static let SelectedMenu = "SelectedMenu"
    static let DismissAllAlert = "DismissAllAlert"
}

class Key {
    static let keyMap = "AIzaSyDGejwLMfyj3XCpOqn4PFRlCZqkc6ZwkYk"
}

class TColor {
    static let mayHong = UIColor("A6A6A6", alpha: 1.0)
    static let mayChuaDangKy = UIColor("36A4A5", alpha: 1.0)
    static let mayDaDangKy = UIColor("CE4F5E", alpha: 1.0)
    static let itsMe = UIColor("CFCFCF", alpha: 1.0)
}

protocol EnumCollection : Hashable {}
extension EnumCollection {
    static func cases() -> AnySequence<Self> {
        typealias S = Self
        return AnySequence { () -> AnyIterator<S> in
            var raw = 0
            return AnyIterator {
                let current : Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
            }
        }
    }
}
