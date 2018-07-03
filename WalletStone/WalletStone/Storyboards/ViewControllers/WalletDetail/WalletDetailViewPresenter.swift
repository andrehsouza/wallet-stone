//
//  WalletDetailViewPresenter.swift
//  WalletStone
//
//  Created by Andre on 13/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation


class WalletDetailViewPresenter {
    
    weak var walletDetailView: WalletDetailViewProtocol?
    
    var priceModel: PriceModel?
    
    init(view: WalletDetailViewProtocol) {
        self.walletDetailView = view
    }
    
}

extension WalletDetailViewPresenter {
    
    func getTransactions(_ wallet: Wallet) -> [Transaction] {
        if let transactions = wallet.transactions {
            let transactionsArray = transactions.sorted(by: { $0.date > $1.date })
            return transactionsArray
        } else {
            return []
        }
    }
    
   func request() {
        
        walletDetailView?.showLoader()
        
        PriceService().getPrices() { result in
            switch(result) {
            case let .success(priceModel):
                self.priceModel = priceModel
                self.walletDetailView?.fillPriceData()
                self.walletDetailView?.hideLoader()
                break
            case let .error(errorMessage):
                self.walletDetailView?.showRequestError(message: errorMessage)
                break
            }
        }
    }
    
}
