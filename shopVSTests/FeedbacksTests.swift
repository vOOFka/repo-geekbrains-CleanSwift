//
//  FeedbacksTests.swift
//  shopVSTests
//
//  Created by Home on 06.03.2022.
//

import XCTest
import Alamofire
@testable import shopVS

class FeedbacksTests: XCTestCase {
    let exectation = XCTestExpectation(description: "FeedbacksTests")
    var errorParser: ErrorParserStub!
    var requestFactory: RequestFactory!
    var timeout: TimeInterval = 5.0
    var newFeedback: Feedback!
    
    override func setUp() {
        super.setUp()
        errorParser = ErrorParserStub()
        requestFactory = RequestFactory()
        newFeedback = Feedback(id: 0, userId: 23525, comment: "Example comment...")
    }
    
    override func tearDown() {
        super.tearDown()
        requestFactory = nil
        errorParser = nil
        newFeedback = nil
    }
    
    func testGetFeedbacks() {
        let feedbacks = requestFactory.makeFeedbacksRequestFactory()
        
        feedbacks.getFeedbacks(pageNumber: 11, productId: 111) { [weak self] (response: AFDataResponse<FeedbacksResult>) in
            switch response.result {
            case .success(let feedbacksResult):
                let feedbacks = feedbacksResult.feedbacks
                if !feedbacks.isEmpty,
                   feedbacks.first != nil {
                    self?.exectation.fulfill()
                } else {
                    XCTFail("Something wrong in getFeedbacks")
                }
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.exectation.fulfill()
        }
        wait(for: [exectation], timeout: timeout)
    }
    
    func testAddFeedback() {
        let feedbacks = requestFactory.makeFeedbacksRequestFactory()
        
        feedbacks.addFeedback(productId: 111, newFeedback: newFeedback) { [weak self] (response: AFDataResponse<FeedbacksResult>) in
            switch response.result {
            case .success(let feedbacksResult):
                let feedbacks = feedbacksResult.feedbacks
                if !feedbacks.isEmpty,
                   let last = feedbacks.last,
                   last == self?.newFeedback {
                    self?.exectation.fulfill()
                } else {
                    XCTFail("Something wrong in addFeedback")
                }
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.exectation.fulfill()
        }
        wait(for: [exectation], timeout: timeout)
    }
    
    func testRemoveFeedback() {
        let feedbacks = requestFactory.makeFeedbacksRequestFactory()
        // Set exist productId, feedbackId
        let feedbackId = 555
        feedbacks.removeFeedback(productId: 222, feedbackId: feedbackId) { [weak self] (response: AFDataResponse<FeedbacksResult>) in
            switch response.result {
            case .success(let feedbacksResult):
                let feedbacks = feedbacksResult.feedbacks.first(where: { feedback in
                    feedback?.id == feedbackId
                })

                if (feedbacks == nil) {
                    self?.exectation.fulfill()
                } else {
                    XCTFail("Something wrong in addFeedback")
                }
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.exectation.fulfill()
        }
        wait(for: [exectation], timeout: timeout)
    }
}
