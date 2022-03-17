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
    //let baseUrl = URL(string: "http://127.0.0.1:8080")!
    let baseUrl = URL(string: "https://shopvs-vaporserver.herokuapp.com/")!
    
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
        let method: HTTPMethod = .post
        let path: String = "signup"
        let encoding: RequestRouterEncoding = .json
        
        let user: User
        
        var parameters: Parameters? {
            return [
                "user" : [
                    "id" : user.id,
                    "login" : user.login,
                    "password" : user.password,
                    "userProfile" : [
                        "name" : user.userProfile.name,
                        "lastname" : user.userProfile.lastname,
                        "email" : user.userProfile.email,
                        "gender" : user.userProfile.gender,
                        "creditCard" : user.userProfile.creditCard,
                        "bio" : user.userProfile.bio
                    ]
                ]
            ]
        }
    }
    
    struct EditProfile: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "editprofile"
        let encoding: RequestRouterEncoding = .json
        
        let user: User
        
        var parameters: Parameters? {
            return [
                "user" : [
                    "id" : user.id,
                    "login" : user.login,
                    "password" : user.password,
                    "userProfile" : [
                        "name" : user.userProfile.name,
                        "lastname" : user.userProfile.lastname,
                        "email" : user.userProfile.email,
                        "gender" : user.userProfile.gender,
                        "creditCard" : user.userProfile.creditCard,
                        "bio" : user.userProfile.bio
                    ]
                ]
            ]
        }
    }
}
