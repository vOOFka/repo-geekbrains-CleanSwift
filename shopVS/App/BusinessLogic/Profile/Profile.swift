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
        let method: HTTPMethod = .get
        let path: String = "registerUser.json"
        
        let userProfile: UserProfile
        
        var parameters: Parameters? {
            return [
                "id_user" : userProfile.user.id,
                "username": userProfile.user.login,
                "password": userProfile.password,
                "email"   : userProfile.email
            ]
        }
    }
    
    struct EditProfile: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "changeUserData.json"
        
        let userProfile: UserProfile
        
        var parameters: Parameters? {
            return [
                "id_user" : userProfile.user.id,
                "username": userProfile.user.login,
                "password": userProfile.password,
                "email"   : userProfile.email,
                "gender"  : userProfile.gender,
                "credit_card" : userProfile.creditCard,
                "bio"     : userProfile.gender
            ]
        }
    }
}
