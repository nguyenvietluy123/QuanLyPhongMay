//
//  FilterVC.swift
//  CarZapp
//
//  Created by Pham Khanh Hoa on 7/12/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import UIKit

class PopupMenuView: UIView {
    @IBOutlet weak var tbFilter: UITableView!
    @IBOutlet weak var ctrHeightViewSort: NSLayoutConstraint!
    @IBOutlet weak var postionYForTable: NSLayoutConstraint!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var viewBorder: UIView!
    
    var arrayTitle = [String]()
    var didDismissHandler: (() -> ())?
    var status: TaskStatus = .New
    var didSelectedAtIndex: ((String) -> Void)?
    var isHRRecords: Bool = false
    var isHRAbsent: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "PopupMenuView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func setupView() {
        self.initUI()
        self.initData()
    }
    
    @objc func tappedOnView(sender:UITapGestureRecognizer){
        self.removeFromSuperview()
    }
}

extension PopupMenuView {
    func initUI() {
        tbFilter.separatorStyle = .none
        tbFilter.bounces = false
        viewShadow.layer.shadowOpacity = 0.6
        viewShadow.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewShadow.layer.shadowRadius = 2.0
        viewShadow.layer.shadowColor = UIColor.darkGray.cgColor
        viewShadow.layer.cornerRadius = 2
        viewShadow.clipsToBounds = false

        
        let tapped:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PopupMenuView.tappedOnView(sender:)))
        tapped.numberOfTapsRequired = 1
        tapped.delegate = self
        self.addGestureRecognizer(tapped)
        
        if DeviceType.IS_IPAD {
            postionYForTable.constant = 85 + 10
        } else if DeviceType.IS_IPHONE_X {
            postionYForTable.constant = 59 + UIApplication.shared.statusBarFrame.height + 10
        } else {
            postionYForTable.constant = 75*ScreenSize.SCREEN_HEIGHT/736 + 10
        }
        tbFilter.separatorStyle = .none
    }
    
    func initData() {
        if isHRRecords {
            if isHRAbsent {
                arrayTitle = ["Tạo đơn nghỉ phép", "Tạo đơn nghỉ việc"]
                
                if !Common.checkRole(key: .Taodonnghiphep){
                    if let index = arrayTitle.index(of: "Tạo đơn nghỉ phép") {
                        arrayTitle.remove(at: index)
                    }
                }
                if !Common.checkRole(key: .Taodonnghiviec){
                    if let index = arrayTitle.index(of: "Tạo đơn nghỉ việc") {
                        arrayTitle.remove(at: index)
                    }
                }
            }else{
                arrayTitle = ["Thay đổi hồ sơ", "Thông tin lương - bảo hiểm", "Thông tin khen thưởng", "Thông tin kỷ luật", "Xin nghỉ phép"]
                
                if !Common.checkRole(key: .Thaydoihoso){
                    if let index = arrayTitle.index(of: "Thay đổi hồ sơ") {
                        arrayTitle.remove(at: index)
                    }
                }
                if !Common.checkRole(key: .Thongtinluongbaohiem){
                    if let index = arrayTitle.index(of: "Thông tin lương - bảo hiểm") {
                        arrayTitle.remove(at: index)
                    }
                }
                if !Common.checkRole(key: .Thongtinkhenthuong){
                    if let index = arrayTitle.index(of: "Thông tin khen thưởng") {
                        arrayTitle.remove(at: index)
                    }
                }
                if !Common.checkRole(key: .Thongtinkyluat){
                    if let index = arrayTitle.index(of: "Thông tin kỷ luật") {
                        arrayTitle.remove(at: index)
                    }
                }
                if !Common.checkRole(key: .Xinnghiphep){
                    if let index = arrayTitle.index(of: "Xin nghỉ phép") {
                        arrayTitle.remove(at: index)
                    }
                }
            }
            
        } else {
            switch status {
            case .Completed, .Issued, .Canceled:
                arrayTitle = ["Xem tất cả hình ảnh", "Xem lịch sử cập nhật"]
                if (!TAppDelegate.isHitoryII && !Common.checkRole(key: .Xemtatcahinhanhcuacongviecsethuchien)) || ( TAppDelegate.isHitoryII && !Common.checkRole(key: .Xemtatcahinhanhcuacongviecdahoanthanh)) {
                    if let index = arrayTitle.index(of: "Xem tất cả hình ảnh") {
                        arrayTitle.remove(at: index)
                    }
                }
                if (TAppDelegate.isHitoryII && !Common.checkRole(key: .XemlichsucapnhatLichsucongviec)) || (!TAppDelegate.isHitoryII && !Common.checkRole(key: .XemlichsucapnhatQuanlycongviec)){
                    if let index = arrayTitle.index(of: "Xem lịch sử cập nhật") {
                        arrayTitle.remove(at: index)
                    }
                }
                break
            default:
                arrayTitle = ["Xem tất cả hình ảnh", "Xem lịch sử cập nhật", "Gặp khó khăn"]
                if !Common.checkRole(key: .Xemtatcahinhanhcuacongviecsethuchien){
                    if let index = arrayTitle.index(of: "Xem tất cả hình ảnh") {
                        arrayTitle.remove(at: index)
                    }
                }
                if (TAppDelegate.isHitoryII && !Common.checkRole(key: .XemlichsucapnhatLichsucongviec)) || (!TAppDelegate.isHitoryII && !Common.checkRole(key: .XemlichsucapnhatQuanlycongviec)){
                    if let index = arrayTitle.index(of: "Xem lịch sử cập nhật") {
                        arrayTitle.remove(at: index)
                    }
                }
                if !Common.checkRole(key: .Baocaogapkhokhan){
                    if let index = arrayTitle.index(of: "Gặp khó khăn") {
                        arrayTitle.remove(at: index)
                    }
                }
                break
            }
        }
        
        let space = ScreenSize.SCREEN_MAX_LENGTH - 20 - 60 - (50 + 79)*ScreenSize.SCREEN_MAX_LENGTH/736
        let height = CGFloat(arrayTitle.count)*(35*ScreenSize.SCREEN_MAX_LENGTH/736) + 20
        ctrHeightViewSort.constant = (height > space) ? space : height
        tbFilter.reloadData()
    }
  
}

extension PopupMenuView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            return cell
        }()
        
        cell.textLabel?.text = arrayTitle[indexPath.row]
        cell.textLabel?.font = Common.getFontForDeviceWithFontDefault(fontDefault: UIFont.systemFont(ofSize: 14))
        return cell
    }
}

extension PopupMenuView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectedAtIndex?(arrayTitle[indexPath.row])
        tbFilter.deselectRow(at: indexPath, animated: true)
        self.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35/736*ScreenSize.SCREEN_MAX_LENGTH
    }
}

extension PopupMenuView : UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.isDescendant(of: tbFilter) {
            return false
        }
        return true
    }
}
