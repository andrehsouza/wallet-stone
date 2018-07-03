//
//  PriceService.swift
//  WalletStone
//
//  Created by Andre on 10/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class PriceService: NSObject {
    
    private let endPoint: String = "https://api.promasters.net.br/cotacao/v1/valores"
    
    func getPrices(completion: @escaping (RequestResultType<PriceModel>) -> Void)  {
        let service = APIService<PriceModel>(with: endPoint)
        service.loadData() { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

}
