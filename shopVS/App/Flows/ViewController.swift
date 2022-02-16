//
//  ViewController.swift
//  shopVS
//
//  Created by Home on 12.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let requestFactory = RequestFactory()
    private let currentUser = User(login: "exit551", password: "SDe#$asdA", email: "exit551@ya.ru")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authRequest()
        //logoutRequest()
        //signUpRequest()
        //editProfileRequest(currentUser)
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
        
        let newUser = User(login: "exit551", password: "SDe#$asdA", email: "exit551@ya.ru")
        
        profile.signUp(user: newUser) { response in
            switch response.result {
            case .success(let signUp):
                print(newUser)
                print(signUp)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func editProfileRequest(_ someUser: User) {
        let profile = requestFactory.makeProfileRequestFatory()
  
        profile.editProfile(user: someUser) { response in
            switch response.result {
            case .success(let editProfile):
                print(someUser)
                print(editProfile)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

