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

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    
    var value: Int {
        switch self {
        case .male: return 0
        case .female : return 1
        }
    }
}
