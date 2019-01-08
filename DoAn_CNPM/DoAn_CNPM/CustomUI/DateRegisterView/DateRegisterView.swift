//
//  DateRegisterView.swift
//  HMKFieldCollector
//
//  Created by Luy Nguyen on 11/14/18.
//  Copyright © 2018 Hoa. All rights reserved.
//

import UIKit

class DateRegisterView: UIView {
    @IBOutlet weak var lblTitle: KHLabel!
    @IBOutlet weak var tfValue: KHTextField!
    
    @IBInspectable open var title: String = "" {
        didSet {
            lblTitle.text = title
        }
    }
    
    @IBInspectable open var placeholder: String = "" {
        didSet {
            tfValue.placeholder = placeholder
        }
    }
    
    var handleAction: ((Double) -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for ctr in self.constraints {
            if ctr.firstAttribute == .height {
                if DeviceType.IS_IPAD {
                    ctr.constant = 85
                } else {
                    ctr.constant = 70*heightRatio
                }
            }
        }
    }
    
    @IBAction func actionChoose(_ sender: Any) {
        showActionSheetDatePicker(title: lblTitle.text!, mode: .date, sender: sender as! UIButton)
    }
    
}

extension DateRegisterView {
    func initializeSubviews() {
        let xibFileName = "DateRegisterView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    func showActionSheetDatePicker(title: String, mode: UIDatePicker.Mode, sender: UIButton){
        ActionSheetDatePicker.show(withTitle: title, datePickerMode: mode, selectedDate: Date(), doneBlock: { (picker, selectedDate, origin) in
            if let date = selectedDate as? Date {
                self.tfValue.text = date.string("dd/MM/yyyy")
                self.handleAction?(date.startDate.secondsSince1970)
            }
        }, cancel: { (picker) in
        }, origin: sender)
    }
}
