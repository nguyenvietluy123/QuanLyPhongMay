//
//  MenuObj.swift
//  Carenefit
//
//  Created by Hoa Phan on 9/14/17.
//  Copyright © 2017 sdc. All rights reserved.
//

import UIKit

class DeployItemView: UIView {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imvBackground: UIImageView!
    @IBOutlet weak var imvIcon: UIImageView!
    
    @IBInspectable open var style: Int = 1 {
        didSet {
            switch style {
            case 1:
                lbTitle.text = "Danh sách công việc"
                imvBackground.image = #imageLiteral(resourceName: "target_day")
                imvIcon.image = #imageLiteral(resourceName: "deploy_calendar")
                break
            case 2:
                lbTitle.text = "Công việc đã check-in"
                imvBackground.image = #imageLiteral(resourceName: "target_week")
                imvIcon.image = #imageLiteral(resourceName: "deploy_calendar")
                break
            default:
                lbTitle.text = "Bản đồ thực địa"
                imvBackground.image = #imageLiteral(resourceName: "deploy_background_map")
                imvIcon.image = #imageLiteral(resourceName: "deploy_map")
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
        let xibFileName = "DeployItemView" // xib extention not included
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
