//
//  WalletHomeViewController.swift
//  WalletStone
//
//  Created by Andre Souza on 12/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class WalletHomeViewController: UITabBarController {
    
    fileprivate lazy var presenter: WalletHomeViewPresenter = WalletHomeViewPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        title = item.title
    }
    

}

extension WalletHomeViewController: WalletHomeViewProtocol {
    
    func changeTab(index: WalletHomeTabs) {
        selectedIndex = index.rawValue
    }
    
}
