//
//  RootViewController.swift
//  FOWalletPlus
//
//  Created by Sleep on 2018/11/14.
//  Copyright © 2018 Sleep. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        makeUI()
        createChildren()
    }
    
    private func makeUI() {
        UIApplication.shared.statusBarStyle = .lightContent
//        tabBar.tintColor = TINT_COLOR
        let tabbar = MyTabbar()
        tabbar.tintColor = TINT_COLOR
        setValue(tabbar, forKey: "tabBar")
    }
    
    private func createChildren() {
        let homeTitle = LanguageHelper.localizedString(key: "Home")
        let home = HomeViewController(left: nil, title: nil, right: "img|plus")
        home.tabBarItem.title = homeTitle
        home.tabBarItem.image = UIImage(named: "home")
        home.tabBarItem.selectedImage = UIImage(named: "home_high")
        
        let dappTitle = LanguageHelper.localizedString(key: "DApp")
        let dapp = DAppViewController(left: nil, title: dappTitle, right: nil)
        dapp.tabBarItem.title = "DApp Store"
        dapp.tabBarItem.image = UIImage(named: "dapp")
        dapp.tabBarItem.selectedImage = UIImage(named: "dapp_high")
        
        let meTitle = LanguageHelper.localizedString(key: "Me")
        let me = MeViewController(left: nil, title: meTitle, right: nil)
        me.tabBarItem.title = meTitle
        me.tabBarItem.image = UIImage(named: "me")
        me.tabBarItem.selectedImage = UIImage(named: "me_high")
        
        let homeNav = RootNavigationController(rootViewController: home)
        let dappNav = RootNavigationController(rootViewController: dapp)
        let meNav = RootNavigationController(rootViewController: me)
        setViewControllers([homeNav, dappNav, meNav], animated: true)
    }
    
}
