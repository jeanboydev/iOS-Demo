//
//  AboutSubscriptionViewController.swift
//
//  Created by jeanboy on 2017/11/14.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class AboutSubscriptionViewController: BaseNavigationViewController {
    
    var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexString: "FFFFFF")
        
        // 导航栏设置
        navigationBar.backgroundColor = UIColor(hexString: "#679DFF")
        navigationBar.titleLabel.text = "About Subscription"
        navigationBar.leftButton.isHidden = true
        navigationBar.rightButton.isHidden = false
        navigationBar.rightButton.setImage(UIImage(named: "icon_close"), for: UIControlState.normal)
        
        // text view
        textView = UITextView()
        textView.dataDetectorTypes = .link
        textView.isEditable = false
        textView.showsHorizontalScrollIndicator = false
        textView.backgroundColor = UIColor.white
        textView.textColor = UIColor(hexString: "000000")
        textView.font = UIFont.systemFont(ofSize: 14.0)
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10.0)
            make.right.equalToSuperview().offset(-10.0)
            make.top.equalTo(UIScreen.navigationBarHeight)
            make.bottom.equalToSuperview()
        }
        
        let text = """
        Information About \(IAPPurchaseInfo.appName) Subscription
        The app contains auto-renewable subscription with the following rules:
        - Delete duplicate photos, without limit
        - Unlock key feature: Clean up large size videos
        - 1 week, 3-day trial
        - \(IAPPurchaseInfo.defaultPrice) per week
        - Payment will be charged to iTunes Account at confirmation of purchase.
        - You will be able to use all available function for the duration of the subscription.
        - Subscriptions automatically renew at the end of the period unless turned off at least 24 hours before the end of the current period in the account settings.
        - Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal.
        - Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's iTunes Account Settings after purchase.
        - No cancellation of the current subscription is allowed during active subscription period.
        - You may cancel a subscription during its free trial period via the subscription setting through your iTunes account. This must be done 24 hours before the end of the subscription period to avoid being charged. Please visit https://support.apple.com/en-us/HT202039 for more information.
        - You may turn off the auto-renewal of your subscription via your iTunes Account Settings. However, you are not able to cancel the current subscription during its active period.
        - Any unused portion of a free-trial period, will be forfeited when the user purchases \(IAPPurchaseInfo.appName) subscription.
        
        Privacy Policy
        https://sites.google.com/view/sweeperprivacy-policy
        Terms of Use
        https://sites.google.com/view/sweeperterms-of-service
        """
        textView.text = text.replacingOccurrences(of: IAPPurchaseInfo.defaultPrice, with: Defaults[.oneWeekSubscriptionPrice])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // textView的scroll to top需此时调用才生效
        textView.scrollToTop(animated: false)
    }
   
    override func rightNavigationItemClick() {
        doClose()
    }
    
}

