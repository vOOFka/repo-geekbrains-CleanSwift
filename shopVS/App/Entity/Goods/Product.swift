//
//  Product.swift
//  shopVS
//
//  Created by Home on 20.02.2022.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let price: Int
    let description: String
    var feedbacks: [Feedback?] = []
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
}

extension Product: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
