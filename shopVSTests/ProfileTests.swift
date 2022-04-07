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
    var user: User!
    var existUserForEdit: User!
    
    override func setUp() {
        super.setUp()
        errorParser = ErrorParserStub()
        requestFactory = RequestFactory()
        let userProfile = UserProfile(name: "Vladimir", lastname: "Sirel" , email: "exit554@ya.ru", gender: "Male", creditCard: "1234-5678-9101-1121", bio: "")
        user = User(id: 0, login: "exit554", password: "dasd123asd", userProfile: userProfile)
        existUserForEdit = User(id: 123, login: "exit551", password: "dasd123asd", userProfile: userProfile)
    }
    
    override func tearDown() {
        super.tearDown()
        requestFactory = nil
        errorParser = nil
        user = nil
    }
    
    func testSignUp() {
        let profile = requestFactory.makeProfileRequestFactory()
        
        profile.signUp(user: user) { [weak self] (response: AFDataResponse<ProfileResult>) in
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
        let profile = requestFactory.makeProfileRequestFactory()
        
        profile.editProfile(user: existUserForEdit) { [weak self] (response: AFDataResponse<ProfileResult>) in
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
