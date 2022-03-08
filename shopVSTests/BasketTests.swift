//
//  BasketTests.swift
//  shopVSTests
//
//  Created by Home on 08.03.2022.
//

import XCTest
import Alamofire
@testable import shopVS

class BasketTests: XCTestCase {
    let exectation = XCTestExpectation(description: "BasketTests")
    var errorParser: ErrorParserStub!
    var requestFactory: RequestFactory!
    var timeout: TimeInterval = 5.0
    
    override func setUp() {
        super.setUp()
        errorParser = ErrorParserStub()
        requestFactory = RequestFactory()
        
        let productFirst = Product(id: 111, name: "Notebook ASUS", price: 3000, description: "Super fast notebook")
        let productSecond = Product(id: 222, name: "Iphone", price: 2000, description: "Great phone")

        UserBasket.shared.addProduct(productFirst)
        UserBasket.shared.addProduct(productSecond)
    }
    
    override func tearDown() {
        super.tearDown()
        requestFactory = nil
        errorParser = nil
        UserBasket.shared.clearProducts()
    }
    
    func testGetFeedbacks() {
        let basket = requestFactory.makeBasketRequestFactory()
        
        basket.payBasket(userId: 111) { [weak self] (response: AFDataResponse<BasketResult>) in
            switch response.result {
            case .success(let basketResult):
                if basketResult.result == 0 {
                    XCTFail("Something wrong in payBasket")
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
