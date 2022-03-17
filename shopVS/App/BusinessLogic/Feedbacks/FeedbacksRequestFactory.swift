//
//  FeedbacksRequestFactory.swift
//  shopVS
//
//  Created by Home on 02.03.2022.
//

import Foundation
import Alamofire

protocol FeedbacksRequestFactory {
    func getFeedbacks(pageNumber: Int, productId: Int, completionHandler: @escaping (AFDataResponse<FeedbacksResult>) -> Void)
    func addFeedback(productId: Int, newFeedback: Feedback, completionHandler: @escaping (AFDataResponse<FeedbacksResult>) -> Void)
    func removeFeedback(productId: Int, feedbackId: Int, completionHandler: @escaping (AFDataResponse<FeedbacksResult>) -> Void)
}
