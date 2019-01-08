//
//  MenuObj.swift
//  Carenefit
//
//  Created by Hoa Phan on 9/14/17.
//  Copyright © 2017 sdc. All rights reserved.
//

import UIKit

class TargetItemView: UIView {
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var imvBackground: UIImageView!
    
    @IBInspectable open var style: Int = 1 {
        didSet {
            switch style {
            case 1:
                lbDate.text = "NGÀY"
                imvBackground.image = #imageLiteral(resourceName: "target_day")
                break
            case 2:
                lbDate.text = "TUẦN"
                imvBackground.image = #imageLiteral(resourceName: "target_week")
                break
            default:
                lbDate.text = "THÁNG"
                imvBackground.image = #imageLiteral(resourceName: "deploy_background_map")
                break
            }
        }
    }
    
    var handleAction:(() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "TargetItemView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func action(_ sender: Any) {
        handleAction?()
    }
}
