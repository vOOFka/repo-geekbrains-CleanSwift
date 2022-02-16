//
//  ViewController.swift
//  shopVS
//
//  Created by Home on 12.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let requestFactory = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //authRequest()
        //logoutRequest()
        //signUpRequest()
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
        let signup = requestFactory.makeProfileRequestFatory()
        
        let newUser = User(login: "exit551", password: "SDe#$asdA", email: "exit551@ya.ru")
        
        signup.signUp(user: newUser) { response in
            switch response.result {
            case .success(let signup):
                print(newUser)
                print(signup)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

