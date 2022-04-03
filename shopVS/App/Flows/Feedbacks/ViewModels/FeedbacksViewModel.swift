//
//  FeedbacksViewModel.swift
//  shopVS
//
//  Created by Home on 03.04.2022.
//

import Foundation

final class FeedbacksViewModel {
    private let requestFactory = RequestFactory()
    private(set) var cellsArray: Result<[FeedbackViewCellModel]>?
    
    func update(pageNumber: Int, productId: Int, completion: @escaping () -> Void) {
        let feedbacks = requestFactory.makeFeedbacksRequestFactory()
        feedbacks.getFeedbacks(pageNumber: pageNumber, productId: productId) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let feedbacksResult):
                if feedbacksResult.result == 1 {
                    self.cellsArray = .Success(feedbacksResult.feedbacks.compactMap{ FeedbackViewCellModel(feedback: $0) })
                } else {
                    self.cellsArray = .Failure(feedbacksResult.errorMessage ?? "Unknow error, please try again later.")
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
