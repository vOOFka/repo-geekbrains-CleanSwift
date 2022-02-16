//
//  Profile.swift
//  shopVS
//
//  Created by Home on 16.02.2022.
//

import Foundation
import Alamofire

class Profile: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Profile: ProfileRequestFactory {
    func signUp(user: User, completionHandler: @escaping (AFDataResponse<ProfileResult>) -> Void) {
        let requestModel = SignUp(baseUrl: baseUrl, user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func editProfile(user: User, completionHandler: @escaping (AFDataResponse<ProfileResult>) -> Void) {
        let requestModel = EditProfile(baseUrl: baseUrl, user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }    
}

extension Profile {
    struct SignUp: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "registerUser.json"
        
        let user: User
        
        var parameters: Parameters? {
            return [
                "id_user" : user.id,
                "username": user.login,
                "password": user.password,
                "email"   : user.email
            ]
        }
    }
    
    struct EditProfile: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "changeUserData.json"
        
        let user: User
        
        var parameters: Parameters? {
            return [
                "id_user" : user.id,
                "username": user.login,
                "password": user.password,
                "email"   : user.email,
                "gender"  : user.gender,
                "credit_card" : user.creditCard,
                "bio"     : user.gender
            ]
        }
    }
}
