//
//  LoginCell.swift
//  Audible
//
//  Created by Luy Nguyen on 9/23/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    @IBOutlet weak var tfEmail: KHTextField!
    @IBOutlet weak var tfPassword: KHTextField!
    
    static let reuseIdentifier = "LoginCell"

    var param: [[String : String]] = [[:]]
    var handleLogin: (([[String : String]]) ->())?
    var handleLogin2: ((String, String) -> ())?
    
    override func awakeFromNib() {
        tfEmail.borderWidth = 0.5
        tfPassword.borderWidth = 0.5
        tfEmail.borderColor = UIColor(red: 115/255, green: 178/255, blue: 205/255, alpha: 1)
        tfPassword.borderColor = UIColor(red: 115/255, green: 178/255, blue: 205/255, alpha: 1)
        
        
//        #if targetEnvironment(simulator)
        tfEmail.text = "thongtran@gmail.com"
        tfPassword.text = "123456"
//        #endif
    }
    
    @IBAction func handleLogin(_ sender: Any) {
        self.endEditing(true)
        
        if isValid() {
//            param = [["username" : tfEmail.text],
//                     ["password" : tfPassword.text]] as! [[String : String]]
            handleLogin2?(tfEmail.text ?? "", tfPassword.text ?? "")
//            handleLogin?(param)
        }
    }
    
    func isValid() -> Bool {
        if tfEmail.text == "" {
            Common.showAlert("Vui lòng nhập email")
            return false
        }
        if tfPassword.text == "" {
            Common.showAlert("Vui lòng nhập mật khẩu")
            return false
        }
        return true
    }
}
