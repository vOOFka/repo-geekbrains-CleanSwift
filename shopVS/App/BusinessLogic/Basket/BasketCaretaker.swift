//
//  BasketCaretaker.swift
//  shopVS
//
//  Created by Home on 08.03.2022.
//

import Foundation

final class BasketCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "BasketCaretaker"
    
    func save(products: [Product]) {
        do {
            let data = try self.encoder.encode(products)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveProducts() -> [Product] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            Logger.shared.logEvent("Products is empty")
            return []
        }
        do {
            return try self.decoder.decode([Product].self, from: data)
        } catch {
            Logger.shared.logError(error: error, param: ["file" : #file, "func" : #function])
            return []
        }
    }
    
    func getTotalSum(of products: [Product]) -> Int {
        products.map({$0.price}).reduce(0, +)
    }
}
