//
//  Wallet.swift
//  WalletStone
//
//  Created by Andre on 10/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation
import CoreData

enum Cryptocurrency: Int {
    
    case real      = 0
    case dolar     = 1
    case bitcoin   = 2
    case brita     = 3
    
    var name: String {
        switch self {
        case .real:
            return "Real"
        case .bitcoin:
            return "Bitcoin"
        case .brita:
            return "Brita"
        case .dolar:
            return "Dolar"
        }
    }
    
    var symbol: String {
        switch self {
        case .real:
            return "R$"
        case .bitcoin:
            return "BTC"
        case .brita:
            return "BRT"
        case .dolar:
            return "USD"
        }
    }
    
}

@objc(Wallet)
class Wallet: NSManagedObject {
    
    @NSManaged private var type: NSNumber?
    @NSManaged private var balance: NSNumber?
    @NSManaged var customer: Customer
    @NSManaged var transactions: Set<Transaction>?
    
    private var oldValue: Double = 0.0
    private var balanceKey: String = "balance"
    
}

extension Wallet {
    
    var cryptoCurrency: Cryptocurrency {
        get {
            guard
                let cryptoType = self.type,
                let cryptoEnum = Cryptocurrency(rawValue: cryptoType.intValue)
                else { return Cryptocurrency.real }
            return cryptoEnum
        }
        set {
            self.type = NSNumber(value: newValue.rawValue)
        }
    }
    
    var balanceValue: Double {
        get {
            let value = self.balance?.doubleValue ?? 0.0
            return value
        }
        set {
            self.balance = NSNumber(value: newValue)
        }
    }
    
    override func didChangeValue(forKey key: String) {
        if key == balanceKey {
            let newValue = self.balance?.doubleValue ?? 0.0
            let type: TransactionType = (oldValue < newValue) ? .sum : .subtraction
            let transactionValue = type == .subtraction ? (oldValue - newValue) : (newValue - oldValue)
            createTransaction(type, transactionValue)
        }
    }
    
    override func willChangeValue(forKey key: String) {
        if key == balanceKey {
            oldValue = self.balance?.doubleValue ?? 0.0
        }
    }
    
    private func createTransaction(_ type: TransactionType, _ value: Double) {
        let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let transaction = managedContext.insert(entity: Transaction.self)
        transaction.transactionType = type
        transaction.value = value.decimalFormat()
        transaction.wallet = self
        transactions?.insert(transaction)
    }
    
    
}
