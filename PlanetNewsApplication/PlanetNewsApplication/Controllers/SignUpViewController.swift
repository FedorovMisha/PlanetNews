import UIKit

class SignUpViewController: UIViewController {
    let userManager = UserManagerService()
    lazy var authorizationManager: Authorization = {
        AuthorizationService(userManger: self.userManager)
    }()
    var signUpView: SignUpView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signUpView = SignUpView(self, frame: UIScreen.main.bounds)
        self.view.addSubview(signUpView)
    }
    
    @objc func didTouchBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func didNameInputEnd(_ textField: UITextField) -> Bool {
        let nameValidator = NameValidator(userName: textField.text)
        let validationResult = nameValidator.validate()
        updateTextFieldByValidationResult(textField, result: validationResult)
        return validationResult.success
    }
    
    @objc func didEmailEditingEnd(_ textField: UITextField) -> Bool {
        let emailValidator = EmailValidator(email: textField.text)
        let validationResult = emailValidator.validate()
        updateTextFieldByValidationResult(textField, result: validationResult)
        return validationResult.success
    }
    
    @objc func didPasswordInputEnd(_ textField: UITextField) -> Bool {
        let passwordValidator = PasswordValidator(password: textField.text)
        let validationResult = passwordValidator.validate()
        updateTextFieldByValidationResult(textField, result: validationResult)
        return validationResult.success
    }
    
    @objc func didPasswordInputStart(_ textField: UITextField) {
        if let confirmPassword = signUpView.confirmPasswordInput {
            confirmPassword.text = ""
            confirmPassword.attributedPlaceholder = NSAttributedString(string: confirmPassword.placeholder ?? "None", attributes: [.foregroundColor: BackgroundColors.baseInputBorderGray])
        }
    }
    
    @objc func didConfirmPasswordInputEnd(_ textField: UITextField) -> Bool {
        let confirmPasswordValidator = ConfirmPasswordValidator(password: signUpView.passwordInput?.text, confirmPassword: textField.text)
        let validationResult = confirmPasswordValidator.validate()
        if let passwordInput = signUpView.passwordInput, !validationResult.success {
            updateTextFieldByValidationResult(passwordInput, result: validationResult)
        }
        updateTextFieldByValidationResult(textField, result: validationResult)
        
        return validationResult.success
    }
    
    @objc func didTouchSignUp() {
        guard let userNameInput = signUpView.userNameInput,
              let emailInput = signUpView.emailInput,
              let passwordInput = signUpView.passwordInput,
              let confirmPasswordInput = signUpView.confirmPasswordInput else {
                  return
              }
        
        let nameResult = didNameInputEnd(userNameInput)
        let emailResult = didEmailEditingEnd(emailInput)
        let passwordResult = didPasswordInputEnd(passwordInput)
        let confirmPasswordResult = didConfirmPasswordInputEnd(confirmPasswordInput)
        
        guard nameResult && emailResult && passwordResult && confirmPasswordResult else {
            return
        }
        let signUpCredentials = SignUpCredentials(name: userNameInput.text!,
                                                  email: emailInput.text!,
                                                  password: passwordInput.text!,
                                                  confirmPassword: confirmPasswordInput.text!)
        guard authorizationManager.signUp(signUpCredentials) else {
            let alertController = UIAlertController(title: "Sign Up Error", message: "Some ... 😎 \n - Current user is exists", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard self.authorizationManager.signIn(SignInCredentials(email: signUpCredentials.email, password: signUpCredentials.password)) else {
            return
        }
        
        let vc = TestViewController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func updateTextFieldByValidationResult(_ field: UITextField, result: ValidationResult) {
        if result.success {
            field.textColor = .systemGreen
            return
        }
        
        if let text = field.text, !text.isEmpty {
            field.textColor = .red
        } else {
            field.attributedPlaceholder = NSAttributedString(string: field.placeholder ?? "Error", attributes: [.foregroundColor: UIColor.red])
        }
    }
}
