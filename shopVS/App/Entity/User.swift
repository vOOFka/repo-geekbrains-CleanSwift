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
    let name: String
    let lastname: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case login = "user_login"
        case name = "user_name"
        case lastname = "user_lastname"
    }
    
    init(login: String, name: String, lastname: String) {
        self.id = abs(Int(UUID().uuidString.hash))
        self.login = login
        self.name = name
        self.lastname = lastname
    }
}
