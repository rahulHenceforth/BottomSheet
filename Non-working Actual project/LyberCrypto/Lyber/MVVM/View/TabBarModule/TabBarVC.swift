//
//  TabBarVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 08/09/21.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
    
}

//MARK:- INITIAL SET UP
extension TabBarVC{
    func initialSetUp(){
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.layer.cornerRadius = 32
        tabBar.barTintColor = .appWhiteColor
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.MontserratMedium(Size.Small.sizeValue())], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.MontserratMedium(Size.Small.sizeValue())], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.primaryTextColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.themeColor], for: .selected)
    }
}
