//
//  ViewController.swift
//  shopVS
//
//  Created by Home on 12.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let requestFactory = RequestFactory()
    private let currentUser = User(id: 0140828713151909195,
                                   login: "exit551",
                                   password: "asdasfa2321",
                                   userProfile: UserProfile(name: "Vladimir",
                                                            lastname: "Sirel",
                                                            email: "exit551@ya.ru",
                                                            creditCard: "1234-5678-9101-0000"))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //authRequest()
        //logoutRequest()
        //signUpRequest()
        //editProfileRequest(currentUser)
        //getGoodsRequest(pageNumber: 1, categoryId: 123)
        //getProductRequest(productId: 111)
        getFeedbacksRequest(pageNumber: 1, productId: 111)
    }
    
    private func authRequest() {
        let auth = requestFactory.makeAuthRequestFactory()
        
        auth.login(userName: "vOOFka", password: "qwerty123") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func logoutRequest() {
        let auth = requestFactory.makeAuthRequestFactory()
        
        auth.logout(userId: 2361194105334859860) { response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func signUpRequest() {
        let profile = requestFactory.makeProfileRequestFactory()
        
        let newProfile = UserProfile(name: "Vladimir", lastname: "Sirel" , email: "exit551@ya.ru", creditCard: "1234-5678-9101-1121")
        let newUser = User(id: 0, login: "exit551", password: "dasd123asd", userProfile: newProfile)
        
        
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
        let profile = requestFactory.makeProfileRequestFactory()
        
        profile.editProfile(user: someUser) { response in
            switch response.result {
            case .success(let editUser):
                print(someUser)
                print(editUser)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getGoodsRequest(pageNumber: Int, categoryId: Int) {
        let goods = requestFactory.makeGoodsRequestFactory()
        
        goods.getCatalogData(pageNumber: pageNumber, categoryId: categoryId) { response in
            switch response.result {
            case .success(let goods):
                print(goods)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getProductRequest(productId: Int) {
        let goods = requestFactory.makeGoodsRequestFactory()
        
        goods.getProduct(productId: productId) { response in
            switch response.result {
            case .success(let product):
                print(product)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getFeedbacksRequest(pageNumber: Int, productId: Int) {
        let feedbacks = requestFactory.makeFeedbacksRequestFactory()
        
        feedbacks.getFeedbacks(pageNumber: pageNumber, productId: productId) { response in
            switch response.result {
            case .success(let feedbacks):
                print(feedbacks)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

