//
//  AuthTests.swift
//  shopVSTests
//
//  Created by Home on 21.02.2022.
//

import XCTest
import Alamofire
@testable import shopVS

class AuthTests: XCTestCase {
    let exectation = XCTestExpectation(description: "AuthTests")
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
    
    func testLogin() {
        let auth = requestFactory.makeAuthRequestFatory()
        
        auth.login(userName: "vOOFka", password: "qwerty123") { [weak self] (response: AFDataResponse<AuthResult>) in
            switch response.result {
            case .success(let loginResult):
                if loginResult.result == 1 {
                    self?.exectation.fulfill()
                } else {
                    XCTFail("Something wrong in login")
                }
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.exectation.fulfill()
        }
        wait(for: [exectation], timeout: timeout)
    }
    
    func testLogout() {
        let auth = requestFactory.makeAuthRequestFatory()
        
        auth.logout(userId: 123) { [weak self] (response: AFDataResponse<AuthResult>) in
            switch response.result {
            case .success(let logoutResult):
                if logoutResult.result == 0 {
                    XCTFail("Something wrong in logout")
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
