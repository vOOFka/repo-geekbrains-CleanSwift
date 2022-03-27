//
//  AppSessionCaretaker.swift
//  shopVS
//
//  Created by Home on 27.03.2022.
//

import UIKit

final class AppSessionCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "AppSessionUser"
    
    func save(userOfSession: AppSession) {
        do {
            let data = try self.encoder.encode(AppSession.shared.currentUser)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveSessionUser() -> User? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        do {
            return try self.decoder.decode(User.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
