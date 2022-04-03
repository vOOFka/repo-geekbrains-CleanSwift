//
//  FeedbackViewCellModel.swift
//  shopVS
//
//  Created by Home on 03.04.2022.
//

import Foundation

final class FeedbackViewCellModel {
    private(set) var name: String
    private(set) var comment: String
    
    init(feedback: Feedback) {
        self.name = String(feedback.userId)
        self.comment = feedback.comment
    }
}
