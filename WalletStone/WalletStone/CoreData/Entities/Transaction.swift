//
//  Transaction.swift
//  WalletStone
//
//  Created by Andre on 10/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit
import Foundation
import CoreData

enum TransactionType: Int {
    
    case sum            = 0
    case subtraction    = 1
    
    var symbol: String {
        switch self {
        case .sum:
            return "+"
        case .subtraction:
            return "-"
        }
    }
    
    var color: UIColor {
        switch self {
        case .sum:
            return .darkGreen
        case .subtraction:
            return .red
        }
    }
}

@objc(Transaction)
class Transaction: CustomNSManagedObject, FetchableProtocol {
    
    @NSManaged private var type: NSNumber?
    @NSManaged var wallet: Wallet?
    @NSManaged var date: Date
    @NSManaged var value: String?

}

extension Transaction {
    
    var transactionType: TransactionType {
        get {
            guard
                let type = self.type,
                let transcationEnum = TransactionType(rawValue: type.intValue)
                else { return TransactionType.sum }
            return transcationEnum
        }
        set {
            self.type = NSNumber(value: newValue.rawValue)
        }
    }
    
    override public func awakeFromInsert() {
        date = Date()
    }
}
