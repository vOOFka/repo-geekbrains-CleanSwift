//
//  Feedback.swift
//  shopVS
//
//  Created by Home on 02.03.2022.
//

import Foundation

struct Feedback: Codable {
    let id: Int
    let userId: Int
    let comment: String
}

extension Feedback: Equatable {
    static func == (lhs: Feedback, rhs: Feedback) -> Bool {
        return lhs.userId == rhs.userId && lhs.comment == rhs.comment
    }
}
