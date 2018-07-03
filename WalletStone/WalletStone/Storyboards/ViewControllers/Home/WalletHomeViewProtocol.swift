//
//  WalletHomeViewProtocol.swift
//  WalletStone
//
//  Created by Andre on 12/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

public enum WalletHomeTabs: Int {
    case wallets
    case exchange
    case about
}

protocol WalletHomeViewProtocol: class {
    func changeTab(index: WalletHomeTabs)
}


