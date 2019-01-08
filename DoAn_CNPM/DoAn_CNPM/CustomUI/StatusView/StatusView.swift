//
//  NotificationVC.swift
//  CarZapp
//
//  Created by Pham Khanh Hoa on 9/6/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import UIKit

class StatusView: UIView {
    @IBOutlet weak var imvStatus: UIImageView!
    @IBOutlet weak var lbStatus: KHLabel!
    
    @IBInspectable open var isList: Bool = true
    
    var taskStatus: TaskStatus = .New {
        didSet {
            imvStatus.image = (isList) ? taskStatus.image() : taskStatus.imageDetail()
            lbStatus.text = taskStatus.description()
        }
    }
    
    var deliveryPointStatus: DeliveryPointStatus = .New {
        didSet {
            imvStatus.image = (isList) ? deliveryPointStatus.image() : deliveryPointStatus.imageDetail()
            lbStatus.text = deliveryPointStatus.description()
        }
    }
    
    var inventoryStockStatus: InventoryStockCountStatus = .New {
        didSet {
            imvStatus.image = (isList) ? inventoryStockStatus.image() : inventoryStockStatus.imageDetail()
            lbStatus.text = inventoryStockStatus.description()
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
        let xibFileName = "StatusView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for ctr in self.constraints {
            if ctr.firstAttribute == .height {
                if DeviceType.IS_IPAD {
                    ctr.constant = 45
                } else {
                    ctr.constant = 30*heightRatio + ((DeviceType.IS_IPHONE_5) ? 5 : 0)
                }
            } else if ctr.firstAttribute == .width {
                if DeviceType.IS_IPAD {
                    ctr.constant = 165
                } else {
                    ctr.constant = 110*widthRatio + ((DeviceType.IS_IPHONE_5) ? 5 : 0)
                }
            }
            print(ctr.constant)
        }
        self.layoutIfNeeded()
    }
}
