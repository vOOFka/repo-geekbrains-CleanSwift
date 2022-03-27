//
//  UserProfileViewController.swift
//  shopVS
//
//  Created by Home on 27.03.2022.
//

import UIKit

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
    
    // MARK: - Properties
    private let requestFactory = RequestFactory()
    private var activeFrame = CGRect.zero
    private var currentUser = AppSession.shared.currentUser
    
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
        loginTextField.text = currentUser?.login
        nameTextField.text = currentUser?.userProfile.name
        lastNameTextField.text = currentUser?.userProfile.lastname
        emailTextField.text = currentUser?.userProfile.email
        genderSegmentedControl.selectedSegmentIndex = selectGenderSegmentedControl(gender: currentUser?.userProfile.gender) ?? 0
        creditCardTextField.text = currentUser?.userProfile.creditCard
        bioTextView.text = currentUser?.userProfile.bio
    }
    
    private func selectGenderSegmentedControl(gender: String?) -> Int? {
        Gender(rawValue: gender ?? "Male")?.value
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
    
    private func profileRequest() {
        let _ = requestFactory.makeProfileRequestFactory()

    }
    
    // MARK: - Actions
    
    @IBAction private func enterButtonTap(_ sender: Any) {
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
