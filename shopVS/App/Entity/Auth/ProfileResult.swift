//
//  ProfileResult.swift
//  shopVS
//
//  Created by Home on 16.02.2022.
//

import Foundation

struct ProfileResult: Codable {
    var result: Int
    var userId: Int?
    var userMessage: String?
    var errorMessage: String?
}
