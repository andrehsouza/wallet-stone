//
//  CurrencyModel.swift
//  WalletStone
//
//  Created by Andre on 10/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

struct CurrencyModel: Codable {
    
    var font: String?
    var value: Double?
    var date: Int?
    
    enum CodingKeys: String, CodingKey {
        case font = "fonte"
        case value = "valor"
        case date = "ultima_consulta"
    }
}

