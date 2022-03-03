//
//  ProductResult.swift
//  shopVS
//
//  Created by Home on 20.02.2022.
//

import Foundation

struct ProductResult: Codable {
    let name: String
    let price: Int
    let description: String
    let result: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "product_name"
        case price = "product_price"
        case description = "product_description"
        case result
    }
}
