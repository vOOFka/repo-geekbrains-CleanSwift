//
//  CatalogResult.swift
//  shopVS
//
//  Created by Home on 20.02.2022.
//

import Foundation

struct CatalogResult: Codable {
    var result: Int
    var errorMessage: String?
    let pageNumber: Int?
    let goods: [Product]?
}
