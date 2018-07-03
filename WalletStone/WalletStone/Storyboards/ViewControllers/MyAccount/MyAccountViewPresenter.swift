//
//  MyAccountViewPresenter.swift
//  WalletStone
//
//  Created by Andre on 13/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

class MyAccountViewPresenter {
    
    weak var mAccountViewProtocol: MyAccountViewProtocol?
    
    init(view: MyAccountViewProtocol) {
        self.mAccountViewProtocol = view
    }

    func logout() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: Login.email)
        userDefaults.removeObject(forKey: Login.password)
        userDefaults.removeObject(forKey: Login.isAutomatic)
        userDefaults.synchronize()
    }
    
}

