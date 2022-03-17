//
//  UserProfile.swift
//  shopVS
//
//  Created by Home on 16.02.2022.
//

import Foundation

struct UserProfile: Codable {
    let name: String
    let lastname: String
    let email: String
    var gender: String = ""
    let creditCard: String
    var bio: String = ""
}
