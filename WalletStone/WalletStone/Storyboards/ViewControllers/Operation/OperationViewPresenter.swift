//
//  OperationViewPresenter.swift
//  WalletStone
//
//  Created by Andre on 13/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

class OperationViewPresenter {
    
    weak var operationViewProtocol: OperationViewProtocol?
    
    init(view: OperationViewProtocol) {
        self.operationViewProtocol = view
    }
    
}

extension OperationViewPresenter {
    
    func buyCryptoCurrency(operationWallet: Wallet, //wallet que recebe a ação
                            valueDouble: Double, //Valor que recebe
                            currencyValue: Double) { //Valor da moeda no mercado
        
        guard
            let allWallets = WSUtil.shared.customer?.wallets,
            let realWallet = allWallets.filter( {$0.cryptoCurrency == .real }).first
            else {
                return
        }
        
        let realValue = valueDouble * currencyValue
        if(realValue > realWallet.balanceValue) {
            operationViewProtocol?.showMessage(message: "Você não possui dinheiro suficiente para esta compra.")
        } else {
            operationWallet.balanceValue = operationWallet.balanceValue + valueDouble
            realWallet.balanceValue = realWallet.balanceValue - realValue
            CoreDataStack.sharedInstance.saveContext()
            operationViewProtocol?.goToList()
        }
    }
    
    func sellCryptoCurrency(operationWallet: Wallet, //wallet que recebe a ação
                            valueDouble: Double, //Valor que vende
                            currencyValue: Double) { //Valor da moeda no mercado
        
        guard
            let allWallets = WSUtil.shared.customer?.wallets,
            let realWallet = allWallets.filter( {$0.cryptoCurrency == .real }).first
            else {
                return
        }
        
        let realValue = valueDouble * currencyValue
        if(operationWallet.balanceValue < valueDouble) {
            operationViewProtocol?.showMessage(message: "Você não possui dinheiro suficiente para esta venda.")
        } else {
            operationWallet.balanceValue = operationWallet.balanceValue - valueDouble
            realWallet.balanceValue = realWallet.balanceValue + realValue
            CoreDataStack.sharedInstance.saveContext()
            operationViewProtocol?.goToList()
        }
    }
    
}
