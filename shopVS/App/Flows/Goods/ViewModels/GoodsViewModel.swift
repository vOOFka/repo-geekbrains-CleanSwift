//
//  GoodsViewModel.swift
//  shopVS
//
//  Created by Home on 30.03.2022.
//

import Foundation

final class GoodsViewModel {
    private let requestFactory = RequestFactory()
    private(set) var cellsArray: Result<[GoodsViewCellModel]>?
    
    func update(pageNumber: Int, categoryId: Int, completion: @escaping () -> Void) {
        let goods = requestFactory.makeGoodsRequestFactory()
        goods.getCatalogData(pageNumber: pageNumber, categoryId: categoryId) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let catalogResult):
                if catalogResult.result == 1,
                   let goods = catalogResult.goods {
                    self.cellsArray = .Success(goods.compactMap{ GoodsViewCellModel(good: $0) })
                } else {
                    self.cellsArray = .Failure(catalogResult.errorMessage ?? "Unknow error, please try again later.")
                }
            case .failure(let error):
                self.cellsArray = .Failure(error.localizedDescription)
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
