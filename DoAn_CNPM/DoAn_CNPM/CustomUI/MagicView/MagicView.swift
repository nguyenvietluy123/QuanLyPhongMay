//
//  MenuObj.swift
//  Carenefit
//
//  Created by Hoa Phan on 9/14/17.
//  Copyright © 2017 sdc. All rights reserved.
//

import UIKit

class MagicView: UIView {
    @IBInspectable open var targetType: Int = 0 {
        didSet {
            loadTarget()
        }
    }
    
    func loadTarget() {
        switch TimeType(rawValue: targetType) ?? .month {
        case .day:
            style = 1
            break
        case .week:
            style = 2
            break
        case .month:
            style = 3
            break
        }
    }
    
    @IBInspectable open var style: Int = 0 {
        didSet {
            loadStyle()
        }
    }
    
    func loadStyle() {
        switch style {
        case 1:
            gradient(UIColor("15EDED", alpha: 1.0), UIColor("029CF5", alpha: 1.0)) //light blue
            break
        case 2:
            gradient(UIColor("AFF57A", alpha: 1.0), UIColor("54D169", alpha: 1.0)) //green
            break
        case 3:
            gradient(UIColor("5496FF", alpha: 1.0), UIColor("8739E5", alpha: 1.0)) //purple
            break
        case 4:
            gradient(UIColor("FF63DE", alpha: 1.0), UIColor("F0A1C6", alpha: 1.0)) //pink
            break
        case 5:
            gradient(UIColor("FAD961", alpha: 1.0), UIColor("F76B1C", alpha: 1.0)) //yellow
            break
        case 6:
            gradient(UIColor("59C2FF", alpha: 1.0), UIColor("1270E3", alpha: 1.0)) //blue
            break
        default:
            gradient()
            break
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
    
    func initializeSubviews() {
        let xibFileName = "MagicView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for ctr in self.constraints {
            if ctr.firstAttribute == .height {
                ctr.constant = ctr.constant*heightRatio
            }
            
            if ctr.firstAttribute == .width {
                ctr.constant = ctr.constant*widthRatio
            }
        }
    }
    
    func gradient(_ firstColor: UIColor = UIColor.init("15EDED", alpha: 1.0), _ secondColor: UIColor = UIColor.init("029CF5", alpha: 1.0)){
        removeGradientLayer()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0.0, 0.7]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeGradientLayer() {
        if let layers = self.layer.sublayers {
            for ly in layers {
                if ly is CAGradientLayer {
                    ly.removeFromSuperlayer()
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if targetType > 0 {
            loadTarget()
        } else {
            if style > 0 {
                loadStyle()
            }
        }
    }
}
