//
//  BaseVC.swift
//  CNPM
//
//  Created by Luy Nguyen on 12/1/18.
//  Copyright © 2018 Luy Nguyen. All rights reserved.
//


import UIKit

class BaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        TAppDelegate.menuContainerViewController?.setMenuState(MFSideMenuStateClosed, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func menuContainerViewController() -> MFSideMenuContainerViewController {
        return self.navigationController?.parent as! MFSideMenuContainerViewController
    }
    
    func clickMenu() {
        TAppDelegate.menuContainerViewController?.toggleLeftSideMenuCompletion(nil)
    }
    
    func clickBack() {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
}
