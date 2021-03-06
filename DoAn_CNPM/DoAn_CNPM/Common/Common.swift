//
//  File.swift
//  Welio
//
//  Created by Pham Khanh Hoa on 4/12/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

let appleLanguages = "appleLanguages"

class Common {
    static func showAlert(_ strMessage: String){
        self.dismissAllAlert()
        let alert = AlertController(title: "CNPM".localized, message: strMessage.localized, preferredStyle: UIAlertController.Style.alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK".localized, style: .cancel) { action -> Void in
            
        }
        self.addNotificationCenter(observer: alert, selector: #selector(AlertController.hideAlertController), key: NotificationCenterKey.DismissAllAlert)
        alert.addAction(okAction)
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    static func dismissAllAlert() {
        Common.postNotificationCenter(key: NotificationCenterKey.DismissAllAlert, object: nil)
    }
    
    class func getFontForDeviceWithFontDefault(fontDefault:UIFont) -> UIFont {
        var font:UIFont = fontDefault
        var sizeScale: CGFloat = 1
        if DeviceType.IS_IPAD {
            sizeScale = 1.3
        }else if DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_7 {
            sizeScale = 0.95
        }else if DeviceType.IS_IPHONE_5 {
            sizeScale = 0.9
        }
        font = UIFont(name: font.fontName, size: font.pointSize * sizeScale)!
        return font
    }
    
    class func heightOfText(_ text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: font]
        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        return rectangleHeight
    }
    
    class func postNotificationCenter(key: String, object: Any?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: key), object: object)
    }
    
    class func addNotificationCenter(observer: Any,selector: Selector, key: String) {
        removeNotificationCenter(observer: observer, key: key)
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: key), object: nil)
    }
    
    class func removeNotificationCenter(observer: Any, key: String) {
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(rawValue: key), object: nil)
    }
    
    class func formatNumber(number : Int) -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value:number))!
    }
    
    class func viewNoData() -> UIView{
        if let window = UIApplication.shared.keyWindow {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: window.bounds.size.width, height: window.bounds.size.height))
            noDataLabel.text          = "Không có dữ liệu"
            noDataLabel.textColor     = UIColor.gray
            noDataLabel.textAlignment = .center
            let font = UIFont.init(name: "SFProDisplay-Regular", size: 16)
            noDataLabel.font = Common.getFontForDeviceWithFontDefault(fontDefault: font ?? UIFont.systemFont(ofSize: 16))
            return noDataLabel
        } else {
            return UIView()
        }
    }
    
    static func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return  dateFormatter.string(from: date!)
        
    }
}
