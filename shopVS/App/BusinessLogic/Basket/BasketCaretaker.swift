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
            return []
        }
        do {
            return try self.decoder.decode([Product].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
    func getTotalSum(of products: [Product]) -> Int {
        return products.map({$0.price}).reduce(0, +)
    }
}
