//
//  HeaderTableView.swift
//  HMKFieldCollector
//
//  Created by Luy Nguyen on 11/20/18.
//  Copyright © 2018 Hoa. All rights reserved.
//

import UIKit

class HeaderTableView: UIView {
    
    @IBOutlet weak var tabRed: KHView!
    @IBOutlet weak var ctrWidthTabRed: NSLayoutConstraint!
    @IBOutlet weak var numCIF: KHLabel!
    @IBOutlet weak var nameCIF: KHLabel!
    @IBOutlet weak var indentureNum: KHLabel!
    @IBOutlet weak var contractNum: KHLabel!
    
    func configHeader(numCIF: String, nameCIF: String, indentureNum: String, contractNum: String) {
        self.numCIF.text = numCIF.text
        self.nameCIF.text = nameCIF.text
        self.indentureNum.text = indentureNum.text
        self.contractNum.text = contractNum.text
    }
    
    @IBInspectable open var hasTabRed: Bool = false {
        didSet {
            tabRed.isHidden = hasTabRed ? false : true
            ctrWidthTabRed.constant = hasTabRed ? 0*widthRatio : -78*widthRatio
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
        let xibFileName = "HeaderTableView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }


}
