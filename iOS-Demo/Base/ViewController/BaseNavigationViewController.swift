//
//  BaseNavigationViewController.swift
//  使用自定义导航栏时使用
//
//  Created by jeanboy on 2017/12/18.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

class BaseNavigationViewController: BaseViewController {

    var navigationBar: NavigationView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 导航栏左边按钮点击
    func leftNavigationItemClick() {
        if self.navigationController?.viewControllers.count ?? 0 > 1 {
            doBack()
        }
    }
    
    /// 导航栏右边按钮点击
    func rightNavigationItemClick() {
    }
    
    /// 初始化View
    override func initSubViews() {
        super.initSubViews()
        
        //自定义导航栏
        navigationBar = NavigationView()
        navigationBar.backgroundColor = UIColor.init(hexString: AppColor.navigationBar)
        navigationBar.titleLabel.textColor = UIColor.init(hexString: AppColor.navigationBarText)
        self.view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { (make) in
            make.width.top.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.navigationBarHeight)
        }
        
        navigationBar.leftButton.isHidden = self.navigationController?.viewControllers.count ?? 0 <= 1
        navigationBar.leftButton.setImage(UIImage(named: "icon_back"), for: UIControlState.normal)
        
        navigationBar.leftButtonClick = { [weak self] in
            self?.leftNavigationItemClick()
        }
        
        navigationBar.rightButtonClick = {[weak self] in
            self?.rightNavigationItemClick()
        }
    }
}
