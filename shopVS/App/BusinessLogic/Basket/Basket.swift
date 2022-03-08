//
//  Basket.swift
//  shopVS
//
//  Created by Home on 08.03.2022.
//

import Foundation
import Alamofire

class Basket: AbstractRequestFactory {
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

extension Basket: BasketRequestFactory {
    func payBasket(userId: Int, completionHandler: @escaping (AFDataResponse<BasketResult>) -> Void) {
        let requestModel = Basket(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Basket {
    struct Basket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "paybasket"
        let encoding: RequestRouterEncoding = .json
        
        let userId: Int
        
        var parameters: Parameters? {
            return [
                "userId": userId,
                "totalSumma": UserBasket.shared.totalSumma,
                "products" : [ UserBasket.shared.products ]
            ]
        }
    }
}
