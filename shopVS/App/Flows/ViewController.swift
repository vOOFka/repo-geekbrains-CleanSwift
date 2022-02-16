//
//  ViewController.swift
//  shopVS
//
//  Created by Home on 12.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let requestFactory = RequestFactory()
    private let currentUserProfile = UserProfile(user: User(login: "exit551", name: "Vladimir", lastname: "Sirel"),
                                                 password: "asdasfa",
                                                 email: "exit551@ya.ru")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authRequest()
        logoutRequest()
        signUpRequest()
        editProfileRequest(currentUserProfile)
    }
    
    private func authRequest() {
        let auth = requestFactory.makeAuthRequestFatory()
        
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func logoutRequest() {
        let auth = requestFactory.makeAuthRequestFatory()
        
        auth.logout(userId: 123) { response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func signUpRequest() {
        let profile = requestFactory.makeProfileRequestFatory()
        
        let newUser = User(login: "exit551", name: "Vladimir", lastname: "Sirel")
        let newProfile = UserProfile(user: newUser, password: "dasd123asd", email: "exit551@ya.ru")
        
        profile.signUp(userProfile: newProfile) { response in
            switch response.result {
            case .success(let signUp):
                print(newProfile)
                print(signUp)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func editProfileRequest(_ someUserProfile: UserProfile) {
        let profile = requestFactory.makeProfileRequestFatory()
  
        profile.editProfile(userProfile: someUserProfile) { response in
            switch response.result {
            case .success(let editProfile):
                print(someUserProfile)
                print(editProfile)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

