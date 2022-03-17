//
//  FeedbacksResult.swift
//  shopVS
//
//  Created by Home on 02.03.2022.
//

import Foundation

struct FeedbacksResult: Codable {
    var result: Int
    var errorMessage: String?
    let pageNumber: Int?
    let feedbacks: [Feedback?]
}
