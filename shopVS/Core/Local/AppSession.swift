//
//  AppSession.swift
//  shopVS
//
//  Created by Home on 27.03.2022.
//

import Foundation

class AppSession {
    static let shared = AppSession()
    private(set) var currentUser: User? {
        didSet {
            appSessionCaretaker.save(userOfSession: self)
        }
    }
    private let appSessionCaretaker = AppSessionCaretaker()
    
    private init() {
        self.currentUser = self.appSessionCaretaker.retrieveSessionUser()
    }
    
    func cleanUserInSession() {
        self.currentUser = nil
    }
    
    func setUserInSession(user: User) {
        self.currentUser = user
    }
}
