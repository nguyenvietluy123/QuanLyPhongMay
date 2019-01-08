//
//  RoomCell.swift
//  QuanLyPhongMay
//
//  Created by Luy Nguyen on 12/4/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//

import UIKit

class RoomCell: UITableViewCell {
    @IBOutlet weak var lbRoomName: KHLabel!
    @IBOutlet weak var lbNumPC: KHLabel!
    @IBOutlet weak var viewStatusBook: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension RoomCell {
    func config(_ obj: RoomObj) {
        let attributedText = NSMutableAttributedString(string: "Phòng \(obj.rname)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)])
        lbRoomName.attributedText = attributedText
        
        viewStatusBook.backgroundColor = obj.status == .Booked ? TColor.mayDaDangKy : TColor.mayChuaDangKy
        
        backgroundColor = obj.itsMe ? TColor.itsMe : .white
//        if let name = obj.name, let may = obj.may, let tiet = obj.tiet, let statusp = obj.statusp {
//            self.lbRoomName.text = "Phòng \(name)"
//            self.lbNumPC.text = "(\(may) máy) (\(tiet) tiết)"
//
//            switch statusp {
//            case "1":
//                self.viewStatusBook.backgroundColor = TColor.chuaDat
//                break
//            case "2":
//                self.viewStatusBook.backgroundColor = TColor.dangSuDung
//                break
//            case "3":
//                self.viewStatusBook.backgroundColor = TColor.daDat
//                break
//            default:
//                break
//            }
//        }
        
    }
}
