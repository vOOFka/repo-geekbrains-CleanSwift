//
//  User.swift
//  shopVS
//
//  Created by Home on 15.02.2022.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let password: String
    let userProfile: UserProfile
}
