//
//  ProductResult.swift
//  shopVS
//
//  Created by Home on 20.02.2022.
//

import Foundation

struct ProductResult: Codable {
    var result: Int
    var errorMessage: String?
    let product: Product?
}
