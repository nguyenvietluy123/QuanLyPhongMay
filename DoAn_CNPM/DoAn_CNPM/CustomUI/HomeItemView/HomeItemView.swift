//
//  MenuObj.swift
//  Carenefit
//
//  Created by Hoa Phan on 9/14/17.
//  Copyright © 2017 sdc. All rights reserved.
//

import UIKit

class HomeItemView: UIView {
    @IBOutlet weak var magicView: MagicView!
    @IBOutlet weak var lbTitle: KHLabel!
    @IBOutlet weak var lbValue: KHLabel!
    
    var handleBack: (() -> Void)?
    
    @IBInspectable open var title: String = "" {
        didSet {
            lbTitle.text = title
        }
    }
    
    @IBInspectable open var value: String = "" {
        didSet {
            lbValue.text = value
        }
    }
    
    @IBInspectable open var style: Int = 0 {
        didSet {
            magicView.style = style
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    var handleAction: (() -> Void)?
    
    func initializeSubviews() {
        let xibFileName = "HomeItemView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for ctr in self.constraints {
            if ctr.firstAttribute == .height {
                ctr.constant = 66*heightRatio
            }
        }
    }
    
    @IBAction func action(_ sender: Any) {
        handleAction?()
    }
}
