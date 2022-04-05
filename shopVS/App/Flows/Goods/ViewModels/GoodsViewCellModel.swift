//
//  GoodsViewCellModel.swift
//  shopVS
//
//  Created by Home on 02.04.2022.
//

import Foundation

final class GoodsViewCellModel {
    private(set) var id: Int
    private(set) var name: String
    private(set) var price: Int
    private(set) var description: String
    private(set) var feedbacks: [Feedback?] = []
    
    init(good: Product) {
        self.id = good.id
        self.name = good.name
        self.price = good.price
        self.description = good.description
        self.feedbacks = good.feedbacks
    }
}
