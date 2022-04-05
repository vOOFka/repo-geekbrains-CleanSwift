//
//  User.swift
//  shopVS
//
//  Created by Home on 15.02.2022.
//

import Foundation

struct User: Codable {
    let id: Int
    var login: String
    var password: String
    var userProfile: UserProfile
}
