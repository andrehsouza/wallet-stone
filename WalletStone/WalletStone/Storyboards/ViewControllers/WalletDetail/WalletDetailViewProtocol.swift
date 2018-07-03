//
//  WalletDetailViewProtocol.swift
//  WalletStone
//
//  Created by Andre on 13/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

protocol WalletDetailViewProtocol: class {
    func showLoader()
    func hideLoader()
    func showRequestError(message: String)
    func fillPriceData()
}
