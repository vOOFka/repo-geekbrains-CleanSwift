//
//  Feedbacks.swift
//  shopVS
//
//  Created by Home on 02.03.2022.
//

import Foundation
import Alamofire

class Feedbacks: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "http://127.0.0.1:8080")!
    //let baseUrl = URL(string: "https://shopvs-vaporserver.herokuapp.com/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Feedbacks: FeedbacksRequestFactory {
    func getFeedbacks(pageNumber: Int, productId: Int, completionHandler: @escaping (AFDataResponse<FeedbacksResult>) -> Void) {
        let requestModel = GetFeedbacks(baseUrl: baseUrl, pageNumber: pageNumber, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func addFeedback(productId: Int, newFeedback: Feedback, completionHandler: @escaping (AFDataResponse<FeedbacksResult>) -> Void) {
        
    }
    
    func removeFeedback(productId: Int, completionHandler: @escaping (AFDataResponse<FeedbacksResult>) -> Void) {
        
    }
    
//    func getCatalogData(pageNumber: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<CatalogResult>) -> Void) {
//        let requestModel = GetCatalog(baseUrl: baseUrl, pageNumber: pageNumber, categoryId: categoryId)
//        self.request(request: requestModel, completionHandler: completionHandler)
//    }
//
//    func getProduct(productId: Int, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void) {
//        let requestModel = GetProduct(baseUrl: baseUrl, productId: productId)
//        self.request(request: requestModel, completionHandler: completionHandler)
//    }
}

extension Feedbacks {
    struct GetFeedbacks: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getfeedbacks"

        let pageNumber: Int
        let productId: Int

        var parameters: Parameters? {
            return [
                "pageNumber" : pageNumber,
                "productId": productId
            ]
        }
    }
//
//    struct GetProduct: RequestRouter {
//        let baseUrl: URL
//        let method: HTTPMethod = .post
//        let path: String = "productbyid"
//
//        let productId: Int
//
//        var parameters: Parameters? {
//            return [
//                "productId" : productId
//            ]
//        }
//    }
}
