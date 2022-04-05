//
//  BasketViewModel.swift
//  shopVS
//
//  Created by Home on 05.04.2022.
//

import Foundation

final class BasketViewModel {
    private let basket = RequestFactory().makeBasketRequestFactory()
    private(set) var cellsArray: [String] = ["","",""] //Result<[FeedbackViewCellModel]>?
}
