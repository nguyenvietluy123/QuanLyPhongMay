//
//  LoginVC.swift
//  CNPM
//
//  Created by Luy Nguyen on 12/1/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//

import UIKit

var mainUser: UserId = UserId()

class LoginVC: UIViewController {
    @IBOutlet weak var viewCollection: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bottomPageControl: NSLayoutConstraint!
    @IBOutlet weak var botSkipButton: NSLayoutConstraint!
    
    var arrUsers: [UserId] = []
    var pageCurrent = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        initData()
    }

    func initUI(){
        
        registerCell()
        
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor(red: 55/255, green: 153/255, blue: 186/255, alpha: 1)
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func initData() {
        fetch_Users()
    }
    
    func fetch_Users() {
        ApiService.ShareInstance.fetch_Users { (arrUsers) in
            self.arrUsers.append(contentsOf: arrUsers)
        }
    }
    
    
    
    @objc func keyboardShow() {
        
        let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
        collectionView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToView)))
    }
    
    @objc func tapToView() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardHide() {
        collectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func registerCell() {
//        collectionView.register(UINib(nibName: "PageCell1", bundle: nil), forCellWithReuseIdentifier: PageCell1.reuseIdentifier)
        collectionView.register(PageCell1.self)
        collectionView.register(UINib(nibName: "PageCell2", bundle: nil), forCellWithReuseIdentifier: PageCell2.reuseIdentifier)
        collectionView.register(UINib(nibName: "PageCell3", bundle: nil), forCellWithReuseIdentifier: PageCell3.reuseIdentifier)
        collectionView.register(UINib(nibName: "PageCell4", bundle: nil), forCellWithReuseIdentifier: PageCell4.reuseIdentifier)
        collectionView.register(UINib(nibName: "LoginCell", bundle: nil), forCellWithReuseIdentifier: LoginCell.reuseIdentifier)
    }

    @IBAction func skipPage(_ sender: Any) {
        let indexPath = IndexPath(item: 4, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        moveControlOffScreen()
    }
    
    fileprivate func moveControlOffScreen() {
        bottomPageControl.constant = -25
        botSkipButton.constant = -60
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}

extension LoginVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    @available(iOS 10.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as PageCell1
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell4.reuseIdentifier, for: indexPath) as! PageCell4
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell2.reuseIdentifier, for: indexPath) as! PageCell2
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell3.reuseIdentifier, for: indexPath) as! PageCell3
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginCell.reuseIdentifier, for: indexPath) as! LoginCell
            
//            cell.handleLogin = { (param) in
//                if param == [["username": "thongtran@gmail.com"],
//                             ["password": "123456"]] {
//
//                    for i in self.arrUsers.indices {
//                        if self.arrUsers[i].email == "thongtran@gmail.com" {
//                            mainUser = self.arrUsers[i]
//                            mainUser.uid = self.arrUsers[i].id
//                            TAppDelegate.initMenu()
//                        }
//                    }
//                } else if param == [["username": "dungle@gmail.com"],
//                                    ["password": "123"]] {
//
//                    for i in self.arrUsers.indices {
//                        if self.arrUsers[i].email == "dungle@gmail.com" {
//                            mainUser = self.arrUsers[i]
//                            mainUser.uid = self.arrUsers[i].id
//                            TAppDelegate.initMenu()
//                        }
//                    }
//                } else {
//                    Common.showAlert("Nhập sai tên tài khoản hoặc mật khẩu. Vui lòng thử lại")
//                    return
//                }
//            }
            cell.handleLogin2 = { (email, pass) in
                for i in self.arrUsers.indices {
                    if email == self.arrUsers[i].email {
                        if pass == self.arrUsers[i].password {
                            mainUser = self.arrUsers[i]
                            mainUser.uid = self.arrUsers[i].id
                            TAppDelegate.initMenu()
                            return
                        } else {
                            Common.showAlert("Sai mật khẩu. Vui lòng thử lại")
                            return
                        }
                    }
                }
                Common.showAlert("Email không chính xác. Vui lòng thử lại")
            }
            
            return cell
        }

    }

    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageCell = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageCell
        
        if pageCell == 4 {
            moveControlOffScreen()
        } else {
            bottomPageControl.constant = 10
            botSkipButton.constant = 28
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        //        print(UIDevice.current.orientation.isLandscape)
        
        collectionView.collectionViewLayout.invalidateLayout()
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        
        //scroll to indexPath after the rotation is going
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

class LeftPaddedTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
}
