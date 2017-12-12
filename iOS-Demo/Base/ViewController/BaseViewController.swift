//
//  BaseViewController.swift
//  SevenMinutes
//
//  Created by jeanboy on 2017/11/8.
//  Copyright © 2017年 jeanboy. All rights reserved.
//
import UIKit
import SnapKit
import WebKit
import SwiftyUserDefaults

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
   
    
    var isHadLeftButton: Bool = true
    var webView: WKWebView?
    
    var rootView:UIView!
    var navigationBar: NavigationView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubViews()
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
    
    //MARK:- 状态栏白色(全局修改)
//    UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    //MARK:- 状态栏白色(局部修改)
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .lightContent
//    }
    
    
    //MARK:- 自定义返回按钮点击响应
    func doBack(){
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        }
    }
    //MARK:- 自定义关闭按钮响应
    func doClose(){
        dismiss(animated: true, completion: nil)
    }
    
    func leftNavigationItemClick() {
        if self.navigationController?.viewControllers.count ?? 0 > 1 {
            doBack()
        }
    }
    
    func rightNavigationItemClick() {
    }
}

extension BaseViewController {
    
    private func initSubViews(){
        //隐藏系统导航栏，使用自定义导航栏
        self.navigationController?.isNavigationBarHidden = true
        
        //显示安全区域，自动适配 iPhoneX 头部和底部
        rootView = UIView()
        rootView.backgroundColor = UIColor.clear
        view.addSubview(rootView)
        rootView.snp.makeConstraints({ (make) in
            make.width.centerX.equalToSuperview()
            make.top.equalTo(headerSafeAreaHeight)
            make.height.equalTo(screenHeight - headerSafeAreaHeight - footerSafeAreaHeight)
        })
        
        //自定义导航栏
        navigationBar = NavigationView()
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.titleLabel.text = ""
        rootView.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { (make) in
            make.width.top.centerX.equalToSuperview()
            make.height.equalTo(headerBarHeight)
        }
        
        navigationBar.leftButton.isHidden = self.navigationController!.viewControllers.count <= 1
        navigationBar.leftButton.setImage(UIImage(named: "icon_back"), for: UIControlState.normal)
        
        navigationBar.leftButtonClick = { [weak self] in
            self?.leftNavigationItemClick()
        }
        
        navigationBar.rightButtonClick = {[weak self] in
            self?.rightNavigationItemClick()
        }
    }
    
}
