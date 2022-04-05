//
//  UserProfileViewController.swift
//  shopVS
//
//  Created by Home on 27.03.2022.
//

import UIKit
import CoreData

final class UserProfileViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var conformPasswordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var creditCardTextField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var closeBarButton: UIBarButtonItem!
    
    // MARK: - Public properties
    var viewModel: UserProfileViewModel?
    
    // MARK: - Private properties
    private var activeFrame = CGRect.zero
    private var currentUser = AppSession.shared.currentUser
    
    // MARK: - Lifecycle    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        viewModel = UserProfileViewModel()
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
        loginTextField.text = currentUser?.login
        nameTextField.text = currentUser?.userProfile.name
        lastNameTextField.text = currentUser?.userProfile.lastname
        emailTextField.text = currentUser?.userProfile.email
        genderSegmentedControl.selectedSegmentIndex = selectedGenderSegmentIndex(gender: currentUser?.userProfile.gender) ?? 0
        creditCardTextField.text = currentUser?.userProfile.creditCard
        bioTextView.text = currentUser?.userProfile.bio
    }
    
    private func selectedGenderSegmentIndex(gender: String?) -> Int? {
        Gender(rawValue: gender ?? "Male")?.value
    }
    
    private func getGenderString(segmentedControlIndex: Int) -> String {
        segmentedControlIndex == Gender.male.value ? Gender.male.rawValue : Gender.female.rawValue
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
        scrollView.scrollRectToVisible(activeFrame, animated: true)
    }
    
    @objc private func keyboardHide() {
        scrollView.contentInset = .zero
    }
    
    @objc private func hideKeyboard() {
        scrollView.endEditing(true)
    }
    
    func createProfileFromData(userId: Int) -> User {
        let profile = UserProfile(name: nameTextField.text ?? String(),
                                     lastname: lastNameTextField.text ?? String(),
                                     email: emailTextField.text ?? String(),
                                     gender: getGenderString(segmentedControlIndex: genderSegmentedControl.selectedSegmentIndex),
                                     creditCard: creditCardTextField.text ?? String(),
                                     bio: bioTextView.text ?? String()
        )
        
        let user = User(id: userId,
                           login: loginTextField.text ?? String(),
                           password: passwordTextField.text ?? String(),
                           userProfile: profile
        )
        
        return user
    }
    
    // MARK: - Actions
    
    @IBAction private func enterButtonTap(_ sender: Any) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              let conformPassword = conformPasswordTextField.text,
              !login.isEmpty,
              !password.isEmpty,
              !conformPassword.isEmpty,
              password == conformPassword
        else {
            showError(message: "Cant save profile, check the required login passwords fields")
            return
        }
        let userId = currentUser?.id ?? 0
        let user = createProfileFromData(userId: userId)
        viewModel?.profileRequest(for: user) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .Success(_):
                self.dismiss(animated: true)
            case .Failure(let error):
                self.showError(message: error)
            }
        }
    }
    
    @IBAction private func closeBarButtonTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension UserProfileViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeFrame = textField.frame
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeFrame = CGRect.zero
    }
}

extension UserProfileViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.activeFrame = textView.frame
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.activeFrame = CGRect.zero
    }
}
