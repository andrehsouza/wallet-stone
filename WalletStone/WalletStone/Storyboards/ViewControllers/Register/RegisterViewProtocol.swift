//
//  RegisterViewProtocol.swift
//  WalletStone
//
//  Created by Andre on 11/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

protocol RegisterViewProtocol: class {
    func register()
    func goToLogin(with email: String)
}
