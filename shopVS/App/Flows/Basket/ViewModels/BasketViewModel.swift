//
//  BasketViewModel.swift
//  shopVS
//
//  Created by Home on 05.04.2022.
//

import Foundation

final class BasketViewModel {
    // MARK: - Private properties
    private let basket = RequestFactory().makeBasketRequestFactory()
    private var currentUser = AppSession.shared.currentUser
    
    // MARK: - Public properties
    private(set) var goodsCount: Int = 0
    private(set) var totalSumma: Int = 0
    private(set) var cellsArray: [GoodsViewCellModel] = []
    private(set) var payResult: Result<BasketResult>?

    func updateBasket(completion: () -> Void) {
        let allProducts = UserBasket.shared.products.uniqued()
        self.goodsCount = UserBasket.shared.products.count
        self.totalSumma = UserBasket.shared.totalSumma
        self.payResult = nil
        self.cellsArray = allProducts.compactMap({ GoodsViewCellModel(good: $0) })
        completion()
    }
    
    func cleanBasket(completion: () -> Void) {
        UserBasket.shared.clearProducts()
        updateBasket { }
        completion()
    }
    
    func payBasketRequest(completion: @escaping (Result<BasketResult>) -> Void) {
        let allProducts = UserBasket.shared.products
        
        if let currentUser = currentUser,
           !allProducts.isEmpty {
            basket.payBasket(userId: currentUser.id) { response in
                switch response.result {
                case .success(let basketResult):
                    if basketResult.result == 1 {
                        self.payResult = .Success(basketResult)
                        UserBasket.shared.clearProducts()
                    } else {
                        self.payResult = .Failure(basketResult.errorMessage ?? "Unknow error, please try again later.")
                    }
                case .failure(let error):
                    self.payResult = .Failure(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    completion(self.payResult ?? .Failure("Unknow error, please try again later."))
                }
            }
        }
    }
}
