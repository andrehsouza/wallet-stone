//
//  RegisterViewPresenter.swift
//  WalletStone
//
//  Created by Andre on 11/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

class RegisterViewPresenter {
    
    weak var registerProtocol: RegisterViewProtocol?
    
    init(view: RegisterViewProtocol) {
        self.registerProtocol = view
    }

}

//MARK: - Functions - 

extension RegisterViewPresenter {
    
    func register(_ name: String, _ email: String, _ password: String) {
        
        let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        let customer = managedContext.insert(entity: Customer.self)
        customer.name = name
        customer.email = email
        customer.password = password
        
        let cryptoCurrencies:[Cryptocurrency] = [.real, .bitcoin, .brita]
        cryptoCurrencies.forEach() { cryptoCurrency in
            let wallet = managedContext.insert(entity: Wallet.self)
            wallet.cryptoCurrency = cryptoCurrency
            wallet.balanceValue = cryptoCurrency == .real ? 10000.00 : 0.00
            customer.wallets?.insert(wallet)
        }
        
        CoreDataStack.sharedInstance.saveContext()
        
        registerProtocol?.goToLogin(with: email)
    }
    
}
