//
//  ProfileTests.swift
//  shopVSTests
//
//  Created by Home on 23.02.2022.
//

import XCTest
import Alamofire
@testable import shopVS

class ProfileTests: XCTestCase {
    let exectation = XCTestExpectation(description: "ProfileTests")
    var errorParser: ErrorParserStub!
    var requestFactory: RequestFactory!
    var timeout: TimeInterval = 5.0
    var userProfile: UserProfile!
    
    override func setUp() {
        super.setUp()
        errorParser = ErrorParserStub()
        requestFactory = RequestFactory()
        let user = User(id: 0, login: "exit551", password: "dasd123asd")
        userProfile = UserProfile(user: user, name: "Vladimir", lastname: "Sirel" , email: "exit551@ya.ru", creditCard: "1234-5678-9101-1121")
    }
    
    override func tearDown() {
        super.tearDown()
        requestFactory = nil
        errorParser = nil
        userProfile = nil
    }
    
    func testSignUp() {
        let profile = requestFactory.makeProfileRequestFatory()
        
        profile.signUp(userProfile: userProfile) { [weak self] (response: AFDataResponse<ProfileResult>) in
            switch response.result {
            case .success(let profileResult):
                if profileResult.result == 1 {
                    self?.exectation.fulfill()
                } else {
                    XCTFail("Something wrong in SignUp")
                }
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.exectation.fulfill()
        }
        wait(for: [exectation], timeout: timeout)
    }
    
    func testEditProfile() {
        let profile = requestFactory.makeProfileRequestFatory()
        
        profile.editProfile(userProfile: userProfile) { [weak self] (response: AFDataResponse<ProfileResult>) in
            switch response.result {
            case .success(let profileResult):
                if profileResult.result == 1 {
                    self?.exectation.fulfill()
                } else {
                    XCTFail("Something wrong in EditProfile")
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
