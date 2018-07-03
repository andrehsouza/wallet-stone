//
//  PriceModel.swift
//  WalletStone
//
//  Created by Andre on 10/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

struct PriceModel: Codable {
    
    var status: Bool?
    var currencies: [String:CurrencyModel]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case currencies = "valores"
    }
}
