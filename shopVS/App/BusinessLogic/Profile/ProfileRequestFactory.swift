//
//  ProfileRequestFactory.swift
//  shopVS
//
//  Created by Home on 16.02.2022.
//

import Foundation
import Alamofire

protocol ProfileRequestFactory {
    func signUp(userProfile: UserProfile, completionHandler: @escaping (AFDataResponse<ProfileResult>) -> Void)
    func editProfile(userProfile: UserProfile, completionHandler: @escaping (AFDataResponse<ProfileResult>) -> Void)
}
