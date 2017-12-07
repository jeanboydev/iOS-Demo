//
//  AboutWebViewViewController.swift
//  PhoneClear
//
//  Created by jeanboy on 2017/12/5.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class AboutWebViewViewController: BaseViewController {
    
    var webView = WKWebView()
    
    var indicator = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    var urlString:String?
    var titleText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "FFFFFF")
        
        // 导航栏设置
        navigationBar.backgroundColor = UIColor(hexString: "#679DFF")
        navigationBar.titleLabel.text = titleText
        navigationBar.leftButton.isHidden = true
        navigationBar.rightButton.isHidden = false
        navigationBar.rightButton.setImage(UIImage(named: "icon_close"), for: UIControlState.normal)
        
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        webView.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalTo(navigationBar.snp.bottom)
        }
        
        let url = URL.init(string: try urlString!)
        webView.load(URLRequest.init(url: url!))
        
        
        //添加loading
        indicator.center = CGPoint.init(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func rightNavigationItemClick() {
        dismiss(animated: true, completion: nil)
    }
}

extension AboutWebViewViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        indicator.stopAnimating()
    }
}
