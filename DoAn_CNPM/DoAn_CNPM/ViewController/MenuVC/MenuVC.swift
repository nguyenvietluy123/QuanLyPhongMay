//
//  MenuVC.swift
//  CNPM
//
//  Created by Luy Nguyen on 12/1/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//

import UIKit

class MenuObj: NSObject {
    var img: UIImage
    var title: String
    
    init(_ img: UIImage, title: String) {
        self.img = img
        self.title = title
    }
}

class MenuVC: UIViewController {
    @IBOutlet weak var tbMain: UITableView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: KHLabel!
    @IBOutlet weak var lbEmail: KHLabel!
    
    var arrItem: [MenuObj] = {
        let items: [MenuObj] = [MenuObj(#imageLiteral(resourceName: "profile"), title: "Profile"),
                                MenuObj(#imageLiteral(resourceName: "home"), title: "Home"),
                                MenuObj(#imageLiteral(resourceName: "calendar"), title: "Booking"),
                                MenuObj(#imageLiteral(resourceName: "logout"), title: "Logout")]
        return items
    }()
    let indicator = UIActivityIndicatorView(style: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.initData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension MenuVC {
    func initUI() {
        tbMain.register(MenuCell.self)
        
        lbName.text = mainUser.fullname
        lbEmail.text = mainUser.email
        indicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        indicator.center = imgAvatar.center
        imgAvatar.addSubview(indicator)
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

        tbMain.reloadData()
//        tbMain.selectRow(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .none)
    }
    
//    func logout(){
//        _ = UIAlertController.present(style: .alert, title: "app_name".localized, message: "Bạn có chắc chắn muốn đăng xuất không?", attributedActionTitles: [("Có", .default), ("Không", .cancel)], handler: { (action) in
//            if action.title == "Có" {
//                self.tbMain.reloadData()
//                loginServiceShared.logout()
//                TAppDelegate.setupLogin()
//            }
//        })
//    }
}

extension MenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MenuCell
        cell.config(arrItem[indexPath.item])
        return cell
    }
    
    
}

extension MenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60*heightRatio
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.item {
        case 0:
            let navi = UINavigationController(rootViewController: ProfileVC.init(nibName: "ProfileVC", bundle: nil))
            navi.isNavigationBarHidden = true
            TAppDelegate.menuContainerViewController?.centerViewController = navi
            break
        case 1:
            let navi = UINavigationController(rootViewController: HomeVC.init(nibName: "HomeVC", bundle: nil))
            navi.isNavigationBarHidden = true
            TAppDelegate.menuContainerViewController?.centerViewController = navi
            break
        case 2:
            let navi = UINavigationController(rootViewController: BookingVC.init(nibName: "BookingVC", bundle: nil))
            navi.isNavigationBarHidden = true
            TAppDelegate.menuContainerViewController?.centerViewController = navi
            break
        case 3:
            TAppDelegate.setupLogin()
            break
        default:
            Common.showAlert("Đang phát triển")
            break
        }
    }
}

extension MenuVC {
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
                self.imgAvatar.image = UIImage(data: data)
                self.indicator.stopAnimating()
            }
        }
    }
}
