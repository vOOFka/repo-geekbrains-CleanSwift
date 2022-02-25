//
//  Goods.swift
//  shopVS
//
//  Created by Home on 20.02.2022.
//

import Foundation
import Alamofire

class Goods: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "http://127.0.0.1:8080")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Goods: GoodsRequestFactory {
    func getCatalogData(pageNumber: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<CatalogResult>) -> Void) {
        let requestModel = GetCatalog(baseUrl: baseUrl, pageNumber: pageNumber, categoryId: categoryId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getProduct(productId: Int, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void) {
        let requestModel = GetProduct(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Goods {
    struct GetCatalog: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "catalogdata"
        
        let pageNumber: Int
        let categoryId: Int
        
        var parameters: Parameters? {
            return [
                "pageNumber" : pageNumber,
                "categoryId": categoryId
            ]
        }
    }
    
    struct GetProduct: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "productbyid"
        
        let productId: Int
        
        var parameters: Parameters? {
            return [
                "productId" : productId
            ]
        }
    }
}
