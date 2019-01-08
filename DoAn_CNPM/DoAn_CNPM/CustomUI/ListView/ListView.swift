//
//  FilterVC.swift
//  CarZapp
//
//  Created by Pham Khanh Hoa on 7/12/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import UIKit

class ListView: UIView {
    @IBOutlet weak var ctrHeightTitle: NSLayoutConstraint!
    @IBOutlet weak var tbList: UITableView!
    @IBOutlet weak var ctrHeightButton: NSLayoutConstraint!
    @IBOutlet weak var ctrHeightTbList: NSLayoutConstraint!
    @IBOutlet weak var lbNoData: KHLabel!
    @IBOutlet weak var lbTitle: KHLabel!
    
    var isTask: Bool = false
    var task: TaskObj = TaskObj()
    var deliveryObj: DeliveryObj = DeliveryObj()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "ListView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func setupView() {
        self.initUI()
        self.initData()
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    func show() {
        setupView()
        TAppDelegate.window?.addSubview(self)
    }
}

extension ListView {
    func initUI() {
        lbNoData.isHidden = ((isTask) ? task.assignees.count : deliveryObj.deliveryItems.count) > 0
        tbList.isHidden = ((isTask) ? task.assignees.count : deliveryObj.deliveryItems.count) == 0
        ctrHeightTitle.constant = (isIPad) ? 70 : 50*heightRatio
        ctrHeightButton.constant = (isIPad) ? 70 : 50*heightRatio
        lbTitle.text = (isTask) ? "txt_user_list" : "txt_product_list"
    }
    
    func initData() {
        
    }
}

extension ListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isTask) ? task.assignees.count : deliveryObj.deliveryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            return cell
        }()
        var text = ""
        if isTask {
            text = task.assignees[indexPath.row].employeeName
        } else {
            let product = deliveryObj.deliveryItems[indexPath.row]
            text = ((product.quantity < 10) ? "0\(product.quantity) " : "\(product.quantity) ") + product.productName
        }
        cell.textLabel?.text = text
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.systemFont(ofSize: 14))
        UIView.animate(withDuration: 0, animations: {
            self.tbList.layoutIfNeeded()
        }) { complete in
            self.ctrHeightTbList.constant = (((self.isTask) ? self.task.assignees.count : self.deliveryObj.deliveryItems.count) > 5) ? heightCellContact*5 : self.tbList.contentSize.height
        }
        return cell
    }
}

extension ListView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCellContact
    }
}
