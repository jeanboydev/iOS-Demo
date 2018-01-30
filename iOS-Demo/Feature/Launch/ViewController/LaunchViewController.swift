//
//  LaunchViewController.swift
//  iOS-Demo
//
//  Created by jeanboy on 2017/12/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

class LaunchViewController: BaseViewController {

    override func initSubViews() {
        super.initSubViews()
        
        //TODO: do something...
        self.view.backgroundColor = UIColor.brown
        
        delayAction(delayTime: 3.0) {
            let homeController = HomeViewController()
            let navigationController = UINavigationController.init(rootViewController: homeController)
            navigationController.setNavigationBarHidden(true, animated: true)
            UIApplication.shared.keyWindow?.rootViewController = navigationController
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }
    }

}
