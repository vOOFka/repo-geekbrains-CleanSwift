//
//  GoodsTests.swift
//  shopVSTests
//
//  Created by Home on 23.02.2022.
//

import XCTest
import Alamofire
@testable import shopVS

class GoodsTests: XCTestCase {
    let exectation = XCTestExpectation(description: "GoodsTests")
    var errorParser: ErrorParserStub!
    var requestFactory: RequestFactory!
    var timeout: TimeInterval = 5.0
    
    override func setUp() {
        super.setUp()
        errorParser = ErrorParserStub()
        requestFactory = RequestFactory()
    }
    
    override func tearDown() {
        super.tearDown()
        requestFactory = nil
        errorParser = nil
    }
    
    func testGetCatalogData() {
        let goods = requestFactory.makeGoodsRequestFatory()
        
        goods.getCatalogData(pageNumber: 1, categoryId: 123) { [weak self] (response: AFDataResponse<CatalogResult>) in
            switch response.result {
            case .success(let catalogResult):
                if !catalogResult.isEmpty {
                    self?.exectation.fulfill()
                } else {
                    XCTFail("Something wrong in getCatalogData")
                }
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.exectation.fulfill()
        }
        wait(for: [exectation], timeout: timeout)
    }
    
    func testGetProduct() {
        let goods = requestFactory.makeGoodsRequestFatory()
        
        goods.getProduct(productId: 123) { [weak self] (response: AFDataResponse<ProductResult>) in
            switch response.result {
            case .success(let productResult):
                if productResult.result == 1 {
                    self?.exectation.fulfill()
                } else {
                    XCTFail("Something wrong in getProduct")
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
