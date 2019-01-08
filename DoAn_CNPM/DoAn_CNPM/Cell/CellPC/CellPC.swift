//
//  ManageEmployeeCell.swift
//  HR
//
//  Created by Hoa on 3/6/18.
//  Copyright © 2018 SDC. All rights reserved.
//

import UIKit
//import Kingfisher

class CellPC: UICollectionViewCell {
    
    @IBOutlet weak var imvPhoto: UIImageView!
    @IBOutlet weak var lbNum: KHLabel!
    @IBOutlet weak var viewStatusCell: KHView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension CellPC {
    func config(_ obj: DeviceObj) {
        self.lbNum.text = obj.dname
        
        switch obj.dstatus {
        case .ok:
            viewStatusCell.backgroundColor = TColor.mayChuaDangKy
            break
        case .fail:
            viewStatusCell.backgroundColor = TColor.mayHong
            break
        case .booked:
            viewStatusCell.backgroundColor = TColor.mayDaDangKy
            break
        }
        
    }
}
