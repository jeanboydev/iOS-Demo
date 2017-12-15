//
//  NavigationView.swift
//  iOS-Demo
//
//  Created by jeanboy on 2017/11/9.
//  Copyright © 2017年 fotoable. All rights reserved.
//

import UIKit

class NavigationView: UIView {
    
    var leftButtonClick: (() -> Void)?
    var rightButtonClick: (() -> Void)?
    
    var leftButton: UIButton!
    var titleLabel: UILabel!
    var rightButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK:- event response methods
extension NavigationView {
    
    @objc func buttonPressed(button: UIButton!) {
        
        if button.isEqual(leftButton) {
            if let leftButtonClick = leftButtonClick {
                leftButtonClick()
            }
        } else {
            if let rightButtonClick = rightButtonClick {
                rightButtonClick()
            }
        }
    }
    
}

//MARK:- private methods
private extension NavigationView {
    
    func initSubViews() {
        leftButton = UIButton()
        leftButton.addTarget(self, action: #selector(buttonPressed(button:)), for: UIControlEvents.touchUpInside)
        addSubview(leftButton)
        leftButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(headerSafeAreaHeight)
            make.left.bottom.equalTo(self)
            make.width.equalTo(60.0)
        }
        
        rightButton = UIButton()
        rightButton.addTarget(self, action: #selector(buttonPressed(button:)), for: UIControlEvents.touchUpInside)
        addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.top.height.width.equalTo(leftButton)
        }
        
        titleLabel = UILabel()
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(leftButton)
        }
        
    }
    
}
