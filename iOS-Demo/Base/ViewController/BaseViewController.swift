//
//  BaseViewController.swift
//  SevenMinutes
//
//  Created by jeanboy on 2017/11/8.
//  Copyright © 2017年 jeanboy. All rights reserved.
//
import UIKit
import SnapKit
import SwiftyUserDefaults

class BaseViewController: UIViewController {
    
    var navigationBar: NavigationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar = NavigationView()
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.titleLabel.text = ""
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints { (make) in
            make.left.right.equalTo(view).offset(0.0)
            make.top.equalTo(view).offset(0.0)
            make.height.equalTo(navigationBarHeight)
        }
        
        navigationBar.leftButton.setImage(UIImage(named: "icon_back"), for: UIControlState.normal)
        navigationBar.leftButton.snp.updateConstraints { (make) in
            make.left.equalTo(-10)
        }
        
        navigationBar.leftButtonClick = { [weak self] in
            self?.leftNavigationItemClick()
        }
        
        navigationBar.rightButtonClick = {[weak self] in
            self?.rightNavigationItemClick()
        }
    }
    
    func leftNavigationItemClick() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    func rightNavigationItemClick() {
    }
    
    //状态栏高亮
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
