//
//  BaseNavigationController.swift
//  使用原生导航栏时使用
//
//  Created by jeanboy on 2017/11/28.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit
import WebKit

class BaseNavigationController: BaseViewController {
    
    //MARK:- 设置导航栏是否显示
    func setNavigationBarHidden(isHidden: Bool){
        self.navigationController?.isNavigationBarHidden = isHidden
    }
    //MARK:- 设置导航栏透明
    func setNavigationBarTransparent(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    //MARK:- 设置导航栏背景颜色
    func setNavigationBarBackgroundColor(color:UIColor){
        self.navigationController?.navigationBar.barTintColor = color//前景色
        self.navigationController?.navigationBar.backgroundColor = color//背景色
    }
    //MARK:- 设置导航栏文字颜色
    func setNavigationBarTintColor(color:UIColor){
        self.navigationController?.navigationBar.tintColor = color//文字颜色
    }
    //MARK:- 设置导航栏标题
    func setNavigationBarTitle(title: String){
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth - 80, height: UIScreen.navigationBarHeight))
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth - 80, height: UIScreen.navigationBarHeight))
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.center = titleView.center
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleView.addSubview(titleLabel)
        self.navigationItem.titleView = titleView
    }
    //MARK:- 设置返回按钮是否隐藏
    func setBackButtonHidden(isHidden: Bool){
        self.navigationItem.setHidesBackButton(isHidden, animated: false)
    }
    //MARK:- 设置返回按钮图标
    func setBackButtonImage(backImage: UIImage){
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.navigationBarHeight, height: UIScreen.navigationBarHeight))
        backButton.setImage(backImage, for: UIControlState.normal)
        let backButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.backBarButtonItem = backButtonItem
    }
    
    //MARK:- 设置左边按钮
    func setLeftButton(leftButton: UIButton){
        leftButton.frame = CGRect(x: 0, y: 0, width: UIScreen.navigationBarHeight, height: UIScreen.navigationBarHeight)
        let leftButtonItem = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftButtonItem//添加左边按钮，返回手势失效
        isHadLeftButton = true
    }
    //MARK:- 设置右边按钮
    func setRightButton(rightButton: UIButton){
        rightButton.frame = CGRect(x: 0, y: 0, width: UIScreen.navigationBarHeight, height: UIScreen.navigationBarHeight)
        let rightButtonItem = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    override func initSubViews() {
        super.initSubViews()
        
        self.navigationController?.isNavigationBarHidden = false
    }
}

