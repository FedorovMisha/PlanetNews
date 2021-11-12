import UIKit

class SignUpViewController: BaseViewController {
    let userManager = UserManagerService()
    lazy var authorizationManager: Authorization = {
        AuthorizationService(userManger: self.userManager)
    }()
    
    lazy var signUpLabel:UILabel = {
        makeSignUpLabel()
    }()
    
    lazy var nameInput:UITextField = {
        makeNameInput()
    }()
    
    lazy var emailInput: UITextField = {
        makeEmailInput()
    }()
    
    lazy var passwordInput: UITextField = {
        makePasswordInput()
    }()
    
    lazy var confirmPasswordInput: UITextField = {
        makeConfirmPasswordInput()
    }()
    
    lazy var submitButton : UIButton = {
        makeSubmitButton()
    }()
    
    lazy var backButton : UIButton = {
        makeBackButton()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.mainLabel.text = "News - find out everything"
        self.joinLabel.text = "Join our community"
        self.contentBox.addSeparator(27)
        self.contentBox.appendView(signUpLabel)
        self.contentBox.addSeparator(37)
        self.contentBox.appendView(nameInput)
        self.contentBox.addSeparator(34)
        self.contentBox.appendView(emailInput)
        self.contentBox.addSeparator(34)
        self.contentBox.appendView(passwordInput)
        self.contentBox.addSeparator(34)
        self.contentBox.appendView(confirmPasswordInput)
        self.contentBox.addSeparator(64)
        self.contentBox.appendView(submitButton)
        self.contentBox.addSeparator(27)
        self.contentBox.appendView(backButton)
    }
}


extension SignUpViewController {
    
    var credentials: SignUpCredentials {
        SignUpCredentials(name: nameInput.text ?? "", email: emailInput.text ?? "", password: passwordInput.text ?? "", confirmPassword: confirmPasswordInput.text ?? "")
    }
    
    @objc func didTouchSignUp(){
        let emailValidator = EmailValidator(email: emailInput.text)
        let nameValidator = NameValidator(userName: nameInput.text)
        let passwordValidator = PasswordValidator(password: passwordInput.text)
        let confirmPasswordValidator = ConfirmPasswordValidator(password: passwordInput.text, confirmPassword: confirmPasswordInput.text)
        
        let formValidator = SignUpCredentialsValidator(credentials, emailValidator: emailValidator, passwordValidator: passwordValidator, confirmPasswordValidator: confirmPasswordValidator, nameValidator: nameValidator)
        
        let formValidationResult = formValidator.validate()
        
        guard formValidationResult.success else {
            let alertController = UIAlertController(title: "Sign Up Error", message: formValidationResult.errors[.formLevel] ?? "Error", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let signUpCredentials = self.credentials
        guard self.authorizationManager.signUp(signUpCredentials) else {
            let alertController = UIAlertController(title: "Sign Up Error", message: "Some ... 😎", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard self.authorizationManager.signIn(SignInCredentials(email: signUpCredentials.email, password: signUpCredentials.password)) else {
            return
        }
        
        let vc = Test()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func didTouchBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didEditingStart(_ textField: UITextField){
        textField.textColor = .white
    }
    
    @objc func didEmailInputEnd(_ textField: UITextField){
        let emailValidator = EmailValidator(email: textField.text)
        let validationResult = emailValidator.validate()
        
        updateFieldByValidatinResult(textField, validationResult: validationResult, oldPlaceholder: "Email",errType: .email)
    }
    
    @objc func didNameInputEnd(_ textField: UITextField){
        let nameValidator = NameValidator(userName: textField.text)
        let validationResult = nameValidator.validate()
        updateFieldByValidatinResult(textField, validationResult: validationResult, oldPlaceholder: "Name",errType: .name)
    }
    
    @objc func didPasswordInputEnd(_ textField: UITextField){
        let passwordValidator = PasswordValidator(password: textField.text)
        let validationResult = passwordValidator.validate()
        updateFieldByValidatinResult(textField, validationResult: validationResult, oldPlaceholder: "Password", errType: .password)
    }
    
    @objc func didConfirmPasswordInputEnd(_ textField: UITextField){
        let passwordValidator = ConfirmPasswordValidator(password: passwordInput.text, confirmPassword: textField.text)
        let validationResult = passwordValidator.validate()
        updateFieldByValidatinResult(passwordInput, validationResult: validationResult, oldPlaceholder: "Password", errType: .confirmPassword)
        updateFieldByValidatinResult(textField, validationResult: validationResult, oldPlaceholder: "Confirm Password", errType: .confirmPassword)
    }
    
    func updateFieldByValidatinResult(_ textField: UITextField,validationResult vr: ValidationResult, oldPlaceholder: String, errType: ValidationErrorTypes){
        
        if vr.success {
            textField.placeholder = oldPlaceholder
            textField.attributedPlaceholder = NSAttributedString(string: oldPlaceholder, attributes: [.foregroundColor: UIColor.white])
            textField.textColor = .white
            return
        }
        
        if let text = textField.text, !text.isEmpty{
            textField.textColor = .red
        }else{
            textField.placeholder = vr.errors[errType] ?? "Incorrect value"
            textField.attributedPlaceholder = NSAttributedString(string: vr.errors[errType] ?? "Incorrect value", attributes: [.foregroundColor: UIColor.red])
        }
        
    }
}
