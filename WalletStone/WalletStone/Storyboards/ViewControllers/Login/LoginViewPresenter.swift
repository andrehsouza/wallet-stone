//
//  LoginViewPresenter.swift
//  WalletStone
//
//  Created by Andre on 11/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

class LoginViewPresenter {
    
    weak var loginProtocol: LoginViewProtocol?
    
    init(view: LoginViewProtocol) {
        self.loginProtocol = view
    }
    
    func saveDefaults(_ email: String, _ password: String, _ isAutomatic: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(email, forKey: Login.email)
        userDefaults.set(password, forKey: Login.password)
        userDefaults.set(isAutomatic, forKey: Login.isAutomatic)
        userDefaults.synchronize()
    }
    
}

//MARK: - Functions -

extension LoginViewPresenter {
    
    func tryLogin(email: String, password: String, isAutomatic: Bool) {
        loginProtocol?.showLoader()
        let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let customerList = managedContext.fetchAll(entity: Customer.self)
        if let customer = customerList.filter( {$0.email == email && $0.password == password }).first {
            saveDefaults(email, password, isAutomatic)
            loginProtocol?.goToHome(with: customer)
        } else {
            loginProtocol?.hideLoader()
            loginProtocol?.showAlert(message: "Usuário não encontrado.")
        }
    }
    
}
