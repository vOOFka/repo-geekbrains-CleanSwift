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
    func signUp(userProfile: UserProfile, completionHandler: @escaping (AFDataResponse<ProfileResult>) -> Void) {
        let requestModel = SignUp(baseUrl: baseUrl, userProfile: userProfile)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func editProfile(userProfile: UserProfile, completionHandler: @escaping (AFDataResponse<ProfileResult>) -> Void) {
        let requestModel = EditProfile(baseUrl: baseUrl, userProfile: userProfile)
        self.request(request: requestModel, completionHandler: completionHandler)
    }    
}

extension Profile {
    struct SignUp: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "signup"
        let encoding: RequestRouterEncoding = .json
        
        let userProfile: UserProfile
        
        var parameters: Parameters? {
            return [
                "userProfile" : [
                    "user" : [
                        "id": userProfile.user.id,
                        "login": userProfile.user.login,
                        "password": userProfile.user.password
                    ],
                    "name" : userProfile.name,
                    "lastname": userProfile.lastname,
                    "email": userProfile.email,
                    "gender": userProfile.gender,
                    "creditCard": userProfile.creditCard,
                    "bio": userProfile.bio
                ]
            ]
        }
    }
    
    struct EditProfile: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "editprofile"
        let encoding: RequestRouterEncoding = .json
        
        let userProfile: UserProfile
        
        var parameters: Parameters? {
            return [
                "userProfile" : [
                    "user" : [
                        "id": userProfile.user.id,
                        "login": userProfile.user.login,
                        "password": userProfile.user.password
                    ],
                    "name" : userProfile.name,
                    "lastname": userProfile.lastname,
                    "email": userProfile.email,
                    "gender": userProfile.gender,
                    "creditCard": userProfile.creditCard,
                    "bio": userProfile.bio
                ]
            ]
        }
    }
}
