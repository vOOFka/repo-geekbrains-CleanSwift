//
//  AuthResult.swift
//  shopVS
//
//  Created by Home on 15.02.2022.
//

import Foundation

struct AuthResult: Codable {
    let result: Int
    let user: User?
}
