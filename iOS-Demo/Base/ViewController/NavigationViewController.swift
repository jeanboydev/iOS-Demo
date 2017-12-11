//
//  ViewController.swift
//  iOS-Demo
//
//  Created by jeanboy on 2017/11/28.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit
import WebKit

class NavigationViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var isHadLeftButton: Bool = false
    var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK:- 解决自定义 leftBarButtonItem 时，返回手势失效
    override func viewDidAppear(_ animated: Bool) {
        if isHadLeftButton {
            self.navigationController?.interactivePopGestureRecognizer!.delegate = self
            //解决自定义 leftBarButtonItem 并使用 webView 时，返回手势失效
            if webView != nil {
                let tap = UISwipeGestureRecognizer(target:self, action:nil)
                tap.delegate = self
                self.webView?.addGestureRecognizer(tap)
            }
        }
    }
    //MARK:- 解决自定义 leftBarButtonItem 时，返回手势失效，webView 手势处理
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer:
        UIGestureRecognizer) -> Bool {
        return true
    }
    //MARK:- 解决自定义 leftBarButtonItem 时，返回手势失效，手势处理
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer) {
            //只有二级以及以下的页面允许手势返回
            return self.navigationController!.viewControllers.count > 1
        }
        return true
    }
    
    
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
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth - 80, height: headerBarHeight))
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth - 80, height: headerBarHeight))
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
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: navigationBarHeight, height: navigationBarHeight))
        backButton.setImage(backImage, for: UIControlState.normal)
        let backButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.backBarButtonItem = backButtonItem
    }
    //MARK:- 自定义返回按钮点击响应
    @objc func doBack(){
        if let navigationController = navigationController {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @objc func doClose(){
        //MARK:-待测试
        if isBeingPresented {
            dismiss(animated: true, completion: nil)
        }else{
            doBack()
        }
    }
    
    //MARK:- 设置左边按钮
    func setLeftButton(leftButton: UIButton){
        leftButton.frame = CGRect(x: 0, y: 0, width: headerBarHeight, height: headerBarHeight)
        let leftButtonItem = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftButtonItem//添加左边按钮，返回手势失效
        isHadLeftButton = true
    }
    //MARK:- 设置右边按钮
    func setRightButton(rightButton: UIButton){
        rightButton.frame = CGRect(x: 0, y: 0, width: headerBarHeight, height: headerBarHeight)
        let rightButtonItem = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    //MARK:- 状态栏白色(全局修改)
    //UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    //MARK:- 状态栏白色(局部修改)
    //    override var preferredStatusBarStyle: UIStatusBarStyle{
    //        return .lightContent
    //    }
    
}

