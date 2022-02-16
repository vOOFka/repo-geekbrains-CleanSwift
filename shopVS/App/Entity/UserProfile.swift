//
//  UserProfile.swift
//  shopVS
//
//  Created by Home on 16.02.2022.
//

import Foundation

class UserProfile: Codable {
    let user: User
    let password: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
    
    init(user: User, password: String, email: String) {
        self.user = user
        self.password = password
        self.email = email
        self.gender = ""
        self.creditCard = ""
        self.bio = ""
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decode(User.self, forKey: .user)
        self.password = try container.decode(String.self, forKey: .password)
        self.email = try container.decode(String.self, forKey: .email)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.creditCard = try container.decode(String.self, forKey: .creditCard)
        self.bio = try container.decode(String.self, forKey: .bio)
    }
}
