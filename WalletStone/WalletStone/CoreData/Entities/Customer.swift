//
//  Customer.swift
//  WalletStone
//
//  Created by Andre on 10/06/2018.
//  Copyright © 2018 AndreSamples. All rights reserved.
//

import Foundation
import CoreData

@objc(Customer)
class Customer: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var email: String
    @NSManaged var password: String
    @NSManaged var wallets: Set<Wallet>?
    
}
