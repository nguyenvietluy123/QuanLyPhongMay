//
//  NotificationVC.swift
//  CarZapp
//
//  Created by Pham Khanh Hoa on 9/6/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import UIKit

class SearchScanView: UIView {
    @IBOutlet weak var tfSearch: KHTextField!
    
    @IBInspectable open var placeholder: String = "" {
        didSet {
            tfSearch.placeholder = placeholder
        }
    }
    
    var handleSearch: ((String) -> Void)?
    var handleScan: (() -> Void)?
    
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
                    ctr.constant = 70
                } else {
                    ctr.constant = 60*heightRatio
                }
            }
            print(ctr.constant)
        }
    }
    
    @IBAction func actionSearch(_ sender: Any) {
        handleSearch?(tfSearch.text ?? "")
    }
    
    @IBAction func actionScan(_ sender: Any) {
        handleScan?()
    }
}

extension SearchScanView {
    func initializeSubviews() {
        let xibFileName = "SearchScanView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}

extension SearchScanView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSearch?(tfSearch.text ?? "")
        return true
    }
}
