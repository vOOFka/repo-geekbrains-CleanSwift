//
//  ProfileRequestFactory.swift
//  shopVS
//
//  Created by Home on 16.02.2022.
//

import Foundation
import Alamofire

protocol ProfileRequestFactory {
    func signUp(user: User, completionHandler: @escaping (AFDataResponse<ProfileResult>) -> Void)
}
