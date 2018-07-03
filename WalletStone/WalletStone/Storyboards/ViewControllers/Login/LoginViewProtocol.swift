//
//  LoginViewProtocol.swift
//  WalletStone
//
//  Created by Andre on 11/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

protocol LoginViewProtocol: class {
    func goToHome(with customer: Customer)
    func showAlert(message: String)
    func showLoader()
    func hideLoader()
}
