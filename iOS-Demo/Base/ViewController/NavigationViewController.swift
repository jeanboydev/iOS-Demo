//
//  ViewController.swift
//  iOS-Demo
//
//  Created by jeanboy on 2017/11/28.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //自定义导航栏
        self.navigationController?.isNavigationBarHidden = false//是否隐藏
        self.navigationController?.navigationBar.tintColor = UIColor.red//文字颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.cyan//前景色
        self.navigationController?.navigationBar.backgroundColor = UIColor.yellow//背景色
        //导航栏透明
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = true
        
        //状态栏白色(全局修改)
        //UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        //导航栏标题
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        let labelForTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        labelForTitle.font = UIFont.systemFont(ofSize: 17)
        labelForTitle.center = titleView.center
        labelForTitle.text = "文章列表文章列表文章列表文章列表文章列表文章列表"
        titleView.addSubview(labelForTitle)
        self.navigationItem.titleView = titleView
        
        //创建左侧按钮
        let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        leftButton.backgroundColor = UIColor.green
        leftButton.setTitle("leftButton", for: UIControlState.normal)
        let leftButtonItem = UIBarButtonItem(customView: leftButton)
        
        //创建右侧按钮
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        rightButton.backgroundColor = UIColor.red
        rightButton.setTitle("rightButton", for: UIControlState.normal)
        let rightButtonItem = UIBarButtonItem(customView: rightButton)
        
        //创建返回按钮
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        backButton.backgroundColor = UIColor.darkGray
        backButton.setTitle("backButton", for: UIControlState.normal)
        let backButtonItem = UIBarButtonItem(customView: backButton)
        
        //self.navigationItem.setHidesBackButton(false, animated: false)//是否隐藏返回按钮
        
        self.navigationItem.leftBarButtonItem = leftButtonItem//添加左边按钮，返回手势失效
        self.navigationItem.rightBarButtonItem = rightButtonItem
        //self.navigationItem.backBarButtonItem = backButtonItem
        
        
        //修改返回按钮文字
        //let item = UIBarButtonItem(title: "backButton", style: .plain, target: self, action: nil)
        //self.navigationItem.backBarButtonItem = item
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //解决自定义 leftBarButtonItem 时，返回手势失效
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        //解决自定义 leftBarButtonItem 并使用 webView 时，返回手势失效
        //tap.delegate = self
        //self.webView.addGestureRecognizer(tap)
    }
    
    //解决自定义 leftBarButtonItem 时，返回手势失效，webView 手势处理
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer:
        UIGestureRecognizer) -> Bool {
        return true
    }
    
    //解决自定义 leftBarButtonItem 时，返回手势失效，手势处理
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer) {
            //只有二级以及以下的页面允许手势返回
            return self.navigationController!.viewControllers.count > 1
        }
        return true
    }
    
    //自定义返回按钮点击响应
    @objc func doBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //状态栏白色(局部修改)
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

