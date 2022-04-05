//
//  AuthViewModel.swift
//  shopVS
//
//  Created by Home on 02.04.2022.
//

import Foundation

final class AuthViewModel {
    private let requestFactory = RequestFactory()
    private(set) var authResult: Result<AuthResult> = .Failure("Unknow error, please try again later.")
    
    func authRequest(_ login: String, _ password: String, completion: @escaping (Result<AuthResult>) -> Void) {
        let auth = requestFactory.makeAuthRequestFactory()
        
        auth.login(userName: login, password: password) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let loginResult):
                DispatchQueue.main.async {
                    if loginResult.result == 1,
                       let authUser = loginResult.user {
                        AppSession.shared.setUserInSession(user: authUser)
                        self.authResult = .Success(loginResult)
                    } else {
                        self.authResult = .Failure("Unknow error, please try again later.")
                    }
                }
            case .failure(let error):
                self.authResult = .Failure(error.localizedDescription)
            }
            DispatchQueue.main.async {
                completion(self.authResult)
            }
        }
    }
    
    func logoutRequest(completion: @escaping (Result<AuthResult>) -> Void) {
        let auth = requestFactory.makeAuthRequestFactory()
        guard let currentUser = AppSession.shared.currentUser else { return }
        
        auth.logout(userId: currentUser.id) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let logoutResult):
                if logoutResult.result == 1 {
                    AppSession.shared.cleanUserInSession()
                    self.authResult = .Success(logoutResult)
                } else {
                    self.authResult = .Failure("Unknow error, please try again later.")
                }
            case .failure(let error):
                self.authResult = .Failure(error.localizedDescription)
            }
            DispatchQueue.main.async {
                completion(self.authResult)
            }
        }
    }
}
