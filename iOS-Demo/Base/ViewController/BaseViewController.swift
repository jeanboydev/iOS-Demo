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

    //MARK:- 设置导航栏是否显示
    func setNavigationBarHidden(isHidden: Bool){
        self.navigationController?.isNavigationBarHidden = isHidden
    }
    
    //MARK:- 状态栏白色(全局修改)
//    UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    //MARK:- 状态栏白色(局部修改)
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .lightContent
//    }
    
    
    //MARK:- 自定义返回按钮点击响应
    func doBack(){
        if let navigationController = navigationController {
            self.navigationController?.popViewController(animated: true)
        }
    }
    //MARK:- 自定义关闭按钮响应
    func doClose(){
        dismiss(animated: true, completion: nil)
    }
    
    func leftNavigationItemClick() {
        if self.navigationController!.viewControllers.count > 1 {
            doBack()
        }
    }
    
    func rightNavigationItemClick() {
    }
}

extension BaseViewController {
    
    private func initSubViews(){
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
        
        navigationBar.leftButtonClick = { [weak self] in
            self?.leftNavigationItemClick()
        }
        
        navigationBar.rightButtonClick = {[weak self] in
            self?.rightNavigationItemClick()
        }
    }
    
}
