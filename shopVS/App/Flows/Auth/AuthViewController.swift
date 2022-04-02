//
//  AuthViewController.swift
//  shopVS
//
//  Created by Home on 12.02.2022.
//

import UIKit

final class AuthViewController: UIViewController {    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    // MARK: - Properties
    private let requestFactory = RequestFactory()
    private let appService = AppService()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        removeNotifications()
    }
    
    // MARK: - Methods
    private func configUI() {
        loginTextField.text = "Test"
        passwordTextField.text = "qwerty123"
        signUpButton.isEnabled = (AppSession.shared.currentUser != nil) ?  false : true
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func removeNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func hideKeyboardGestre() {
        let hideKeyboardGestre = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGestre)
    }
    
    @objc private func keyboardShow(_ notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let contentInsert = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 10, right: 0)
        
        scrollView.contentInset = contentInsert
        scrollView.scrollIndicatorInsets = contentInsert
        scrollView.scrollRectToVisible(buttonsStackView.frame, animated: true)
    }
    
    @objc private func keyboardHide() {
        scrollView.contentInset = .zero
    }
    
    @objc private func hideKeyboard() {
        scrollView.endEditing(true)
    }
    
    private func authRequest(_ login: String, _ password: String) {
        let auth = requestFactory.makeAuthRequestFactory()
        
        auth.login(userName: login, password: password) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let loginResult):
                DispatchQueue.main.async {
                    if loginResult.result == 1,
                       let authUser = loginResult.user {
                        AppSession.shared.setUserInSession(user: authUser)
                        self.appService.showModalScene(viewController: self, with: .goodsCatalog)
                    } else {
                        self.showError(message: loginResult.errorMessage ?? "Unknow error, please try again later.")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func logoutRequest() {
        let auth = requestFactory.makeAuthRequestFactory()
        guard let currentUser = AppSession.shared.currentUser else { return }
        
        auth.logout(userId: currentUser.id) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let logoutResult):
                DispatchQueue.main.async {
                    if logoutResult.result == 1 {
                        AppSession.shared.cleanUserInSession()
                        self.configUI()
                    } else {
                        self.showError(message: logoutResult.errorMessage ?? "Unknow error, please try again later.")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError(message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func signUpButtonTap(_ sender: Any) {
        appService.showModalScene(viewController: self, with: .userProfile)
    }
    
    @IBAction private func enterButtonTap(_ sender: Any) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              !login.isEmpty,
              !password.isEmpty
        else {
            showError(message: "Need enter login and password")
            return
        }
        authRequest(login, password)
    }
    
    @IBAction func exitButtonTap(_ sender: Any) {
        logoutRequest()
    }
}
