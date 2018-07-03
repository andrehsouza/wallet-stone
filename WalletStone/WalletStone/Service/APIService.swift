//
//  APIService.swift
//  WalletStone
//
//  Created by Andre on 10/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class APIService<T: Codable>: NSObject {
    
    private var endPoint: String?
    
    init(with endPoint: String) {
        super.init()
        self.endPoint = endPoint
    }
    
    func loadData(completion: @escaping (RequestResultType<T>) -> Void) {
        
        guard
            let endPoint = self.endPoint,
            let url = URL(string: endPoint) else {
            completion(.error("URL é inválida"))
            return
        }
        
        printRequest(url: endPoint)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                
                self.handleResponse(data, response)
                
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.error("Erro de decoder: \(error.localizedDescription)"))
                }
                
            } else if let error = error as NSError? {
                completion(.error("Erro: \(error.localizedDescription)"))
            } else {
                completion(.error("Ocorreu um erro, por favor, tente novamente."))
            }
            
            
            }.resume()
        
    }
    
    func printRequest(url: String){
        debugPrint("----------------------- REQUEST ------------------------------")
        debugPrint("GET: \(url)")
        debugPrint("---------------------------------------------------------------")
    }
    
    func handleResponse(_ data: Data, _ response: URLResponse?) {
        if let jsonString = String(data: data, encoding: .utf8) {
            debugPrint("----------------------- RESPONSE ------------------------------")
            debugPrint("Request for \(response?.url?.absoluteString ?? "-sem url-") completed with status code \(response?.getStatusCode() ?? 0)")
            debugPrint("data:")
            debugPrint(jsonString)
            debugPrint("---------------------------------------------------------------")
        }
    }

}
