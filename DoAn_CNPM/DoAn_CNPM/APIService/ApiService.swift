//
//  ApiService.swift
//  Youtube
//
//  Created by Luy Nguyen on 11/6/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    static let ShareInstance = ApiService()
    
    let baseUrl = "https://booking-room-center.herokuapp.com/api/"
    
    func fetch_Users(success: @escaping (([UserId]) -> ())) {
        let url = "\(baseUrl)users"
        apiRequestShared.webServiceCall(url, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (respone) in
            if respone.status {
                success(parseShared.parseListUsers(data: respone.responeJson["data"]))
            }
        }
    }
    
    func fetch_Rooms(success: @escaping (([RoomObj]) -> ())) {
        let url = "\(baseUrl)rooms"
        apiRequestShared.webServiceCall(url, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (respone) in
            if respone.status {
                success(parseShared.parseListRooms(data: respone.responeJson["data"]))
            }
        }
    }
    
    func fetch_PCs(success: @escaping (([DeviceObj]) -> ())) {
        let url = "\(baseUrl)devices"
        apiRequestShared.webServiceCall(url, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (respone) in
            if respone.status {
                success(parseShared.parseListPCs(data: respone.responeJson["data"]))
            }
        }
    }

    func fetch_Lessons(success: @escaping (([LessonObj]) -> ())) {
        let url = "\(baseUrl)lessons"
        apiRequestShared.webServiceCall(url, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (respone) in
            if respone.status {
                success(parseShared.parseListLessons(data: respone.responeJson["data"]))
            }
        }
    }
    
//    http://booking-room-center.herokuapp.com/api/list/booking_rooms
    func fetch_RoomWasBook(success: @escaping (([RoomBookingObj]) -> ())) {
        let url = "\(baseUrl)list/booking_rooms"
        apiRequestShared.webServiceCall(url, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (respone) in
            success(parseShared.parseListRoomBooking(data: respone.responeJson))
        }
    }
    
//   http://booking-room-center.herokuapp.com/api/list/booking_devices
    func fetch_DeviceWasBook(success: @escaping (([DeviceBookingObj]) -> ())) {
        let url = "\(baseUrl)list/booking_devices"
        apiRequestShared.webServiceCall(url, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (respone) in
            success(parseShared.parseListDeviceBooking(data: respone.responeJson))
        }
    }
    
//    https://booking-room-center.herokuapp.com/api/book/booking_rooms?rid=5&lid=1&uid=6&bookdate=2018-12-23
    func book_Room(user: UserId,success: @escaping ((Bool) -> ())) {
        let url = "\(baseUrl)book/booking_rooms?rid=\(user.rid)&lid=\(user.lid)&uid=\(user.uid)&bookdate=\(user.bookdate)"
        apiRequestShared.webServiceCall(url, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (respone) in
            success(respone.responeJson["success"].boolValue)
        }
    }
    
//    https://booking-room-center.herokuapp.com/api/book/booking_devices?did=5&lid=1&uid=6&bookdate=2018-12-23
    func book_Device(user: UserId,success: @escaping ((Bool) -> ())) {
        let url = "\(baseUrl)book/booking_devices?did=\(user.did)&lid=\(user.lid)&uid=\(user.uid)&bookdate=\(user.bookdate)"
        apiRequestShared.webServiceCall(url, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (respone) in
            success(respone.responeJson["success"].boolValue)
        }
    }
    
//    http://booking-room-center.herokuapp.com/api/delete/booking_devices?id=1
    func cancel_Device(id: Int,success: @escaping ((Bool) -> ())) {
        let url = "\(baseUrl)delete/booking_devices?id=\(id)"
        apiRequestShared.webServiceCall(url, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (response) in
            success(response.status)
        }
    }
    
//    http://booking-room-center.herokuapp.com/api/delete/booking_rooms?id=1
    func cancel_Room(id: Int,success: @escaping ((Bool) -> ())) {
        let url = "\(baseUrl)delete/booking_rooms?id=\(id)"
        apiRequestShared.webServiceCall(url, params: nil, isShowLoader: true, method: .get, isHasHeader: true) { (response) in
            success(response.status)
        }
    }
}

let apiServiceShared = ApiService.ShareInstance
