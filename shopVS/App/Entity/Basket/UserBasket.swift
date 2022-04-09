//
//  UserBasket.swift
//  shopVS
//
//  Created by Home on 08.03.2022.
//

import Foundation

class UserBasket {
    static let shared = UserBasket()
    private let basketCaretaker = BasketCaretaker()
    private(set) var products: [Product] = [] {
        didSet {
            basketCaretaker.save(products: self.products)
        }
    }
    private(set) var totalSumma: Int
    
    private init() {
        let products = self.basketCaretaker.retrieveProducts()
        
        self.products = products
        self.totalSumma = self.basketCaretaker.getTotalSum(of: products)
    }
    
    func countInBasket(_ product: Product) -> Int {
        products.filter({ $0.id == product.id }).count
    }
    
    func addProduct(_ product: Product) {
        self.products.append(product)
        self.totalSumma += product.price
    }
    
    func removeProduct(_ product: Product) {
        let index = self.products.firstIndex(where: { basketProduct in
            basketProduct.id == product.id
        })
        
        if let index = index {
            self.products.remove(at: index)
            self.totalSumma -= product.price
        }
    }
    
    func clearProducts() {
        self.products = []
        self.totalSumma = 0
    }
}
