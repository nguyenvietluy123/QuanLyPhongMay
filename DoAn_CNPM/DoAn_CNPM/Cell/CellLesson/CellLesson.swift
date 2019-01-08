//
//  AssignToCell.swift
//  HMKFieldCollector
//
//  Created by Luy Nguyen on 11/26/18.
//  Copyright © 2018 Hoa. All rights reserved.
//

import UIKit

class CellLesson: UITableViewCell {
    @IBOutlet weak var lbName: KHLabel!
    @IBOutlet weak var isCheck: KHImageView!
    @IBOutlet weak var lbTime: KHLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension CellLesson {
    func configCell(_ obj: LessonObj) {
        lbName.text = obj.lname
        lbTime.text = obj.ltime
        backgroundColor = obj.itsMe ? TColor.itsMe : .white
        
        if obj.choose == .Booked {
            isCheck.image = #imageLiteral(resourceName: "checkred")
        } else if obj.choose == .Select {
            isCheck.image = #imageLiteral(resourceName: "checkblue")
        } else {
            isCheck.image = #imageLiteral(resourceName: "check")
        }
    }
}
