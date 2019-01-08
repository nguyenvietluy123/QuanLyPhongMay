//
//  MenuObj.swift
//  Carenefit
//
//  Created by Hoa Phan on 9/14/17.
//  Copyright © 2017 sdc. All rights reserved.
//

import UIKit

class NavigationView: UIView {
    @IBOutlet weak var ctrHeightStatusBar: NSLayoutConstraint!
    @IBOutlet weak var imvShowMenu: UIImageView!
    @IBOutlet weak var ctrHeightImageShowMenu: NSLayoutConstraint!
    @IBOutlet weak var lbTitleNav: KHLabel!
    @IBOutlet weak var viewRight: UIView!
    @IBOutlet weak var imgActionRight: UIImageView!
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var imvBackgoundNavi: UIImageView!
    
    @IBInspectable open var title: String = "" {
        didSet {
            lbTitleNav.text = title.localized
        }
    }
    
    @IBInspectable open var hasLeft: Bool = true {
        didSet {
            viewLeft.isHidden = !hasLeft
        }
    }
    
    @IBInspectable open var hasRight: Bool = false {
        didSet {
            viewRight.isHidden = !hasRight
        }
    }
    
    @IBInspectable open var hasBack: Bool = false {
        didSet {
            if hasBack {
                imvShowMenu.image = #imageLiteral(resourceName: "navi_back")
            }
        }
    }
    
    @IBInspectable open var hasCheckDone: Bool = false {
        didSet {
            if hasCheckDone {
                imgActionRight.image = #imageLiteral(resourceName: "checkDone")
            }
        }
    }
    
    @IBAction func actionRight(_ sender: Any) {
        if hasCheckDone {
            handleCheckDone?()
        }
    }
    
    var handleBack: (() -> Void)?
    var handleMenu: (() -> Void)?
    var handleCheckDone: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "NavigationView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for ctr in self.constraints {
            if ctr.firstAttribute == .height {
                if DeviceType.IS_IPAD {
                    ctr.constant = 85
                } else if DeviceType.IS_IPHONE_X {
                    ctr.constant = 49 + UIApplication.shared.statusBarFrame.height
                } else {
                    ctr.constant = 69*ScreenSize.SCREEN_HEIGHT/736
                }
            }
        }
        ctrHeightStatusBar.constant = UIApplication.shared.statusBarFrame.height
    }
  
    @IBAction func actionHome(_ sender: Any) {
        if hasBack {
            handleBack?()
        }else {
            handleMenu?()
        }
    }

}
