//
//  HomeViewController.swift
//  iOS-Demo
//
//  Created by jeanboy on 2017/12/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {

    
    override func viewDidAppear(_ animated: Bool) {
         self.navigationController?.interactivePopGestureRecognizer!.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.brown
        
        self.navigationController?.navigationBar.tintColor = UIColor.red//文字颜色
//        self.navigationController?.navigationBar.barTintColor = UIColor.cyan//前景色
//        self.navigationController?.navigationBar.backgroundColor = UIColor.yellow//背景色
        //导航栏透明
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        let titleLabel = UILabel(frame: CGRect(x:0,y:0,width:50,height:60))
        titleLabel.text = "LOG IN"
        titleLabel.textColor = UIColor.red
        let navItem = UINavigationItem()
        navItem.titleView = titleLabel
        
        // 创建左侧按钮
        let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        leftButton.backgroundColor = UIColor.green
        leftButton.setTitle("leftButton", for: UIControlState.normal)
        let leftButtonItem = UIBarButtonItem(customView: leftButton)
        
        // 创建右侧按钮
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        rightButton.backgroundColor = UIColor.red
        rightButton.setTitle("rightButton", for: UIControlState.normal)
        let rightButtonItem = UIBarButtonItem(customView: rightButton)
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        backButton.backgroundColor = UIColor.darkGray
        backButton.setTitle("backButton", for: UIControlState.normal)
        let backButtonItem = UIBarButtonItem(customView: backButton)
        
//        self.navigationItem.setHidesBackButton(false, animated: false)
        
        self.navigationItem.leftBarButtonItem = leftButtonItem//添加左边按钮，返回手势失效
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
//        self.navigationItem.backBarButtonItem = backButtonItem
        
        //修改返回文字
//        let item = UIBarButtonItem(title: "backButton", style: .plain, target: self, action: nil)
//        self.navigationItem.backBarButtonItem = item

       
        //新建一个滑动手势
//        let tap = UISwipeGestureRecognizer(target:self, action:nil)
//        tap.delegate = self
//        self.webView.addGestureRecognizer(tap)
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        let labelForTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        labelForTitle.font = UIFont.systemFont(ofSize: 17)
        labelForTitle.center = titleView.center
        labelForTitle.text = "文章列表文章列表文章列表文章列表文章列表文章列表"
        titleView.addSubview(labelForTitle)
        self.navigationItem.titleView = titleView
        
        
        let button = UIButton()
        button.setTitle("点击", for: UIControlState.normal)
        button.backgroundColor = UIColor.purple
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.top.equalTo(navigationBarHeight)
            make.centerX.equalToSuperview()
        }
        button.addTarget(self, action: #selector(doNext), for: UIControlEvents.touchUpInside)
    }

    //返回按钮点击响应
    @objc func backToPrevious(){
        self.navigationController!.popViewController(animated: true)
    }
    
    //返回true表示所有相同类型的手势辨认都会得到处理
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer:
        UIGestureRecognizer) -> Bool {
        return true
    }
    
    //是否启用手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer) {
            //只有二级以及以下的页面允许手势返回
            return self.navigationController!.viewControllers.count > 1
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func doNext(){
        let homeController = HomeViewController()
        self.navigationController?.pushViewController(homeController, animated: true)
    }
    
}
