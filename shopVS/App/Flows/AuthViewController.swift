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
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    // MARK: - Properties
    private let requestFactory = RequestFactory()
    private let currentUser = User(id: 0140828713151909195,
                                   login: "exit551",
                                   password: "asdasfa2321",
                                   userProfile: UserProfile(name: "Vladimir",
                                                            lastname: "Sirel",
                                                            email: "exit551@ya.ru",
                                                            creditCard: "1234-5678-9101-0000"))
    
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
        
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    private func removeNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func hideKeyboardGestre () {
        let hideKeyboardGestre = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGestre)
    }

    @objc private func keyboardShow (_ notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let contentInsert = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 10, right: 0)
        
        scrollView.contentInset = contentInsert
        scrollView.scrollIndicatorInsets = contentInsert
        scrollView.scrollRectToVisible(buttonsStackView.frame, animated: true)
        print(scrollView.contentInset)
    }
    
    @objc private func keyboardHide () {
        scrollView.contentInset = .zero
        print(scrollView.contentInset)
    }
    
    @objc private func hideKeyboard () {
        scrollView.endEditing(true)
    }
    
    private func authRequest() {
        let auth = requestFactory.makeAuthRequestFactory()
        
        auth.login(userName: "vOOFka", password: "qwerty123") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func signUpButtonTap(_ sender: Any) {
    }
    
    @IBAction private func enterButtonTap(_ sender: Any) {
    }
}
