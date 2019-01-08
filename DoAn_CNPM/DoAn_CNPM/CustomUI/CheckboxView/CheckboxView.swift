//
//  SelectionView.swift
//  HMKFieldCollector
//
//  Created by Luy Nguyen on 11/8/18.
//  Copyright © 2018 Hoa. All rights reserved.
//

import UIKit

class CheckboxView: UIView {
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: KHLabel!
    @IBOutlet weak var btnAction: UIButton!
    
    @IBInspectable open var title: String = "" {
        didSet {
            lblTitle.text = title.localized
        }
    }
    
    var handleAction: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "CheckboxView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnActionChoose(_ sender: Any) {
        handleAction?()
    }

    override func layoutSubviews() {
        super .layoutSubviews()
        self.layoutIfNeeded()
    }
}
