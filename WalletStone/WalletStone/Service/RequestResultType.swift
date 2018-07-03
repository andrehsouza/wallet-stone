//
//  RequestResultType.swift
//  WalletStone
//
//  Created by Andre on 10/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

public enum RequestResultType<T> {
    case success(T)
    case error(String)
}
