//
//  ProfileVC.swift
//  CNPM
//
//  Created by Luy Nguyen on 12/3/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//

import UIKit

class ProfileVC: BaseVC {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnShow: KHButton!
    @IBOutlet weak var ctrHeightTableView: NSLayoutConstraint!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbId: UILabel!
    @IBOutlet weak var avatar: KHImageView!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbRole: UILabel!
    
    var arrRoom: [RoomBookingObj] = []
    var arrDevice: [DeviceBookingObj] = []
    var isShow = false
    let indicator = UIActivityIndicatorView(style: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }

    @IBAction func showHistory(_ sender: Any) {
        isShow = !isShow
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.ctrHeightTableView.constant = self.isShow ? 210 : 0
            self.view.layoutIfNeeded()
        }) { (completed) in
        }

    }
}

extension ProfileVC {
    func initUI() {
        navi.handleMenu = {
            self.clickMenu()
        }
        
        lbName.text = mainUser.fullname
        lbId.text = "ID: \(mainUser.id)"
        lbEmail.text = mainUser.email
        lbRole.text = mainUser.role.rawValue == "SV" ? "Sinh Viên" : "Giảng Viên"
        ctrHeightTableView.constant = 0
        view.layoutIfNeeded()
        tableView.register(CellHome.self)
        indicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
//        indicator.center = avatar.center
        indicator.frame = CGRect(x: avatar.frame.width/2 - 12.5 , y: avatar.frame.width/2 - 12.5, width: 50, height: 50)
        avatar.addSubview(indicator)
        indicator.startAnimating()
 
        switch mainUser.email {
        case "thongtran@gmail.com":
            guard let url = URL(string: "https://i.imgur.com/qxJQOgw.jpg") else { return }
            downloadImage(from: url)
            break
        case "dungle@gmail.com":
            guard let url = URL(string: "https://i.imgur.com/lRBxCk9.png") else { return }
            downloadImage(from: url)
            break
        case "hoatran@gmail.com":
            guard let url = URL(string: "https://i.imgur.com/S0B3ayF.jpg") else { return }
            downloadImage(from: url)
            break

        case "luynguyen@gmail.com":
            guard let url = URL(string: "https://i.imgur.com/aKFmNqW.jpg") else { return }
            downloadImage(from: url)
            break

        default:
            return
        }
    }
    
    func initData() {
        fetch_MasterData()
    }
    
    func fetch_MasterData() {
        localDataShared.roomWasBook.removeAll()
        localDataShared.deviceWasBook.removeAll()
        if mainUser.role == .GV {
            apiServiceShared.fetch_RoomWasBook { (arrRoomBooking) in
                for i in arrRoomBooking.indices {
                    if arrRoomBooking[i].uid == mainUser.uid {
                        localDataShared.roomWasBook.append(arrRoomBooking[i])
                    }
                }
                self.arrRoom = localDataShared.roomWasBook
//                self.arrRoom = localDataShared.roomWasBook.sorted {$0.bookdate.localizedStandardCompare($1.bookdate) == .orderedAscending}
//
//                self.arrRoom = self.arrRoom.sorted(by: { (s1, s2) -> Bool in
//                    if s1.bookdate == s2.bookdate {
//                        return s1.rname < s2.rname
//                    }
//                    return false
//                })

                self.tableView.reloadData()
            }
        } else {
            apiServiceShared.fetch_DeviceWasBook { (arrDeviceBooking) in
                for i in arrDeviceBooking.indices {
                    if arrDeviceBooking[i].uid == mainUser.uid {
                        localDataShared.deviceWasBook.append(arrDeviceBooking[i])
                    }
                }
                self.arrDevice = localDataShared.deviceWasBook
//                self.arrDevice = arrDeviceBooking.sorted {$0.bookdate.localizedStandardCompare($1.bookdate) == .orderedAscending}
//
//                self.arrDevice = self.arrDevice.sorted(by: { (s1, s2) -> Bool in
//                    if s1.bookdate == s2.bookdate {
//                        return s1.lname < s2.lname
//                    }
//                    return false
//                })
                
                self.tableView.reloadData()
            }
        }
    }
}

extension ProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainUser.role == .GV ? localDataShared.roomWasBook.count : localDataShared.deviceWasBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellHome
        cell.lbContent.text = "Bạn đã đặt \(mainUser.role == .GV ? "phòng" : "máy" )"
        
        if mainUser.role == .GV {
            cell.lbContent.text = "Bạn đã đặt phòng \(arrRoom[indexPath.item].rname), \(arrRoom[indexPath.item].lname), ngày \(Common.convertDateFormater(arrRoom[indexPath.item].bookdate))"
        } else {
            cell.lbContent.text = "Bạn đã đặt \(arrDevice[indexPath.item].lname) máy \(arrDevice[indexPath.item].dname), ngày \(Common.convertDateFormater(arrDevice[indexPath.item].bookdate))"
        }
        return cell
    }
    
}

extension ProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProfileVC {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.avatar.image = UIImage(data: data)
                self.indicator.stopAnimating()
            }
        }
    }
}
