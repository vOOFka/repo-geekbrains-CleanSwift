//
//  GoodsViewCellModel.swift
//  shopVS
//
//  Created by Home on 02.04.2022.
//

import Foundation

final class GoodsViewCellModel {
    private(set) var product: Product
    private(set) var countInMyCard: Int = 0
    
    init(good: Product) {
        self.product = good
        self.countInMyCard = UserBasket.shared.countInBasket(good)
    }
}
