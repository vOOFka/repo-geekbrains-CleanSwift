//
//  FeedbackViewCellModel.swift
//  shopVS
//
//  Created by Home on 03.04.2022.
//

import Foundation

final class FeedbackViewCellModel {
    private(set) var id: Int
    private(set) var name: String
    private(set) var comment: String
    
    init?(feedback: Feedback?) {
        guard let feedback = feedback else {
            Logger.shared.logError("feesback is nil", param: ["file" : #file, "func" : #function])
            return nil
        }
        self.id = feedback.id
        self.name = String(feedback.userId)
        self.comment = feedback.comment
    }
}
