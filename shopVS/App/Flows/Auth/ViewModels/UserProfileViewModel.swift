//
//  UserProfileViewModel.swift
//  shopVS
//
//  Created by Home on 02.04.2022.
//

import Foundation

final class UserProfileViewModel {
    private let requestFactory = RequestFactory()
    private var currentUser = AppSession.shared.currentUser
    private(set) var profileResult: Result<ProfileResult> = .Failure("Unknow error, please try again later.")
    
    func profileRequest(for user: User, completion: @escaping (Result<ProfileResult>) -> Void) {
        let profile = requestFactory.makeProfileRequestFactory()
        
        if currentUser != nil {
            let editUser = user
            profile.editProfile(user: editUser) { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case .success(let editUserResult):
                    DispatchQueue.main.async {
                        if editUserResult.result == 1,
                           editUser.id == editUserResult.userId {
                            AppSession.shared.setUserInSession(user: editUser)
                            self.profileResult = .Success(editUserResult)
                        } else {
                            self.profileResult = .Failure(editUserResult.errorMessage ?? "Unknow error, please try again later.")
                        }
                    }
                case .failure(let error):
                    self.profileResult = .Failure(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    completion(self.profileResult)
                }
            }
        } else {
            let newProfile = user
            profile.signUp(user: newProfile) { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case .success(let signUpUserResult):
                    DispatchQueue.main.async {
                        if signUpUserResult.result == 1 {
                            AppSession.shared.setUserInSession(user: newProfile)
                            self.profileResult = .Success(signUpUserResult)
                        } else {
                            self.profileResult = .Failure(signUpUserResult.errorMessage ?? "Unknow error, please try again later.")
                        }
                    }
                case .failure(let error):
                    self.profileResult = .Failure(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    completion(self.profileResult)
                }
            }
        }
    }
}
