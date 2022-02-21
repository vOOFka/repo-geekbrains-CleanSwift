//
//  GoodsRequestFactory.swift
//  shopVS
//
//  Created by Home on 20.02.2022.
//

import Foundation
import Alamofire

protocol GoodsRequestFactory {
    func getCatalogData(pageNumber: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<CatalogResult>) -> Void)
    func getProduct(productId: Int, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void)
}
