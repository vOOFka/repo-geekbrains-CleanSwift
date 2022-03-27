//
//  AppServise.swift
//  shopVS
//
//  Created by Home on 27.03.2022.
//

import UIKit

enum SceneIdentifier: String {
    case userProfile = "UserProfileViewController"
    case goodsCatalog = "GoodsTableViewController"
}

class AppService {
    // MARK: - Properties
    // MARK: - Methods
    
    private func getScene(with identifier: SceneIdentifier) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier.rawValue)
    }
    
    func showModalScene(viewController: UIViewController, with identifier: SceneIdentifier) {
        let modalViewController = getScene(with: identifier)
        modalViewController.modalPresentationStyle = .overCurrentContext
        viewController.present(modalViewController, animated: true, completion: nil)
    }
}
