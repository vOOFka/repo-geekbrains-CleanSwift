//
//  BasketRequestFactory.swift
//  shopVS
//
//  Created by Home on 08.03.2022.
//

import Foundation
import Alamofire

protocol BasketRequestFactory {
    func payBasket(userId: Int, completionHandler: @escaping (AFDataResponse<BasketResult>) -> Void) 
}

