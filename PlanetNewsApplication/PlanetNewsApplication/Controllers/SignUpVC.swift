//
//  JoinVC.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 21.10.2021.
//

import UIKit

class SignUpVC: BaseVC {
    let userManager = UserManagerService()
    lazy var authorizationManager: Authorization = {
        AuthorizationService(userManger: self.userManager)
    }()
    
    lazy var signUpLabel:UILabel = {
        let label = UILabel()
        label.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 36.53, yOffSet: 4.52, w: 30, h: 7.2)
        
        label.font = UIFont(name: FontNameDefaults.encodeSansBold, size: self.view.bounds.getPersentByRectHeight(persent: 3.44))
        label.textColor = .white
        label.text = "Sign Up"
        label.textAlignment = .left
        return label
    }()
    
    lazy var nameInput:UITextField = {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 15.47, yOffSet: 17.89, w: 69.33, h: 5.02)
        let textField = createTextInput(placeHolder: "Name", secure: false, frame: frame)
        textField.addTarget(self, action: #selector(self.didEditingStart(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(self.didNameInputEnd(_:)), for: .editingDidEnd)
        return textField
    }()
    
    lazy var emailInput: UITextField = {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 15.47, yOffSet: 28.43, w: 69.33, h: 5.02)
        
        let textField = createTextInput(placeHolder: "Email", secure: false, frame: frame)
        textField.addTarget(self, action: #selector(self.didEditingStart(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(self.didEmailInputEnd(_:)), for: .editingDidEnd)
        
        return textField
    }()
    
    lazy var passwordInput: UITextField = {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 15.47, yOffSet: 39.13, w: 69.33, h: 5.02)
        let textField = createTextInput(placeHolder: "Password", secure: true, frame: frame)
        textField.addTarget(self, action: #selector(self.didEditingStart(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(self.didPasswordInputEnd(_:)), for: .editingDidEnd)
        return textField
    }()
    
    lazy var confirmPasswordInput: UITextField = {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 15.47, yOffSet: 49.83, w: 69.33, h: 5.02)
        let textField = createTextInput(placeHolder: "Confirm Password", secure: true, frame: frame)
        textField.addTarget(self, action: #selector(self.didEditingStart(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(self.didConfirmPasswordInputEnd(_:)), for: .editingDidEnd)
        return textField
    }()
    
    lazy var submitButton : UIButton = {
        let btn = UIButton(type:.system)
        btn.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 7.2, yOffSet: 65.55, w: 85.6, h: 10.03)
        btn.setTitle("SignUp", for: .normal)
        btn.setTitleColor( UIColor.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = self.view.bounds.getPersentByRectHeight(persent: 3.68)
        btn.titleLabel?.font = UIFont(name: FontNameDefaults.robotoMedium, size: self.view.bounds.getPersentByRectHeight(persent: 2.21))
        btn.addTarget(self, action: #selector(didTouchSignUp), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var backButton : UIButton = {
        let fontSize = self.view.bounds.getPersentByRectHeight(persent: 2.2)
        let btn = UIButton(type: .system)
        btn.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 44.8, yOffSet: 78.26, w: 10.67, h: 3.52)
        btn.titleLabel?.font = UIFont(name: FontNameDefaults.robotoMedium, size: fontSize)
        btn.setTitle("back", for: .normal)
        btn.backgroundColor = .clear
        btn.setTitleColor(FontColors.baseGrayColor, for: .normal)
        btn.addTarget(self, action: #selector(self.didTouchBack), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainLabel.text = "News - find out everything"
        self.joinLabel.text = "Join our community"
        self.contentBox.addSubview(signUpLabel)
        self.contentBox.addSubview(nameInput)
        self.contentBox.addSubview(emailInput)
        self.contentBox.addSubview(passwordInput)
        self.contentBox.addSubview(confirmPasswordInput)
        self.contentBox.addSubview(submitButton)
        self.contentBox.addSubview(backButton)
    }
    
}


extension SignUpVC{
    
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
