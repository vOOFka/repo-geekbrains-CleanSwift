//
//  AuthResult.swift
//  shopVS
//
//  Created by Home on 15.02.2022.
//

import Foundation

struct AuthResult: Codable {
    var result: Int
    var user: User?
    var userMessage: String?
    var errorMessage: String?
}
