//
//  HomeViewController.swift
//  iOS-Demo
//
//  Created by jeanboy on 2017/12/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.brown
        
        navigationBar.titleLabel.text = "Home"
        
        let button = UIButton()
        button.setTitle("点击", for: UIControlState.normal)
        button.backgroundColor = UIColor.purple
        self.rootView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.top.equalTo(navigationBar.snp.bottom)
            make.centerX.equalToSuperview()
        }
        button.addTarget(self, action: #selector(doNext), for: UIControlEvents.touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func doNext(){
        let homeController = HomeViewController()
//        self.present(homeController, animated: true, completion: nil)
        self.navigationController?.pushViewController(homeController, animated: true)
    }
    
}
