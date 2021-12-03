import UIKit

class SignUpViewModel {
    enum CellType {
        case textInput(InputTypes), submitButton, backButton
        var cellId: String {
            switch self {
            case .textInput:
                return TextFieldViewCell.id
            case .submitButton:
                return ButtonViewCell.id
            case .backButton:
                return TextButtonViewCell.id
            }
        }
        
        var height: Double {
            switch self {
            case .textInput(.confirmPassword):
                return FlexSize.height(90)
            case .textInput:
                return FlexSize.height(70)
            case .submitButton:
                return FlexSize.height(70)
            case .backButton:
                return FlexSize.height(300)
            }
        }
    }
    
    enum InputTypes {
        case name, email, password, confirmPassword
    }
    
    struct PropertyInfo {
        var placeholder: String = ""
        var value: String = ""
        var isSecure: Bool = false
        var error: String? = nil
    }
    
    var credentials = SignUpCredentials()
    var validationState: [ValidationResult] = []
    var emailValidator = EmailValidator(email: "")
    var nameValidator = NameValidator(name: "")
    var passwordValidator = PasswordValidator(password: "")
    var confirmPasswordValidator = ConfirmPassworValidator(password: "", confirmPassword: "")
    var userManager = UserManager()
    var successSignUpDelegate: ((ApplicationUser) -> Void)?
    var failValidationDelegate: (([ValidationResult]) -> Void)?
    var failSignUpDelegate: (() -> Void)?
    
    func propertyInfo(by type: InputTypes) -> PropertyInfo {
        switch type {
        case .name:
            return PropertyInfo(placeholder: "Name",
                                value: credentials.name,
                                error: getError(by: type))
        case .email:
            return PropertyInfo(placeholder: "Email",
                                value: credentials.email,
                                error: getError(by: type))
        case .password:
            return PropertyInfo(placeholder: "Password",
                                value: credentials.password,
                                isSecure: true,
                                error: getError(by: type))
        case .confirmPassword:
            return PropertyInfo(placeholder: "Confirm password",
                                value: credentials.confirmPassword,
                                isSecure: true,
                                error: getError(by: type))
        }
    }
    
    func updateField(by key: InputTypes, text: String) {
        switch key {
        case .name:
            credentials.name = text
            nameValidator.name = text
        case .email:
            credentials.email = text
            emailValidator.email = text
        case .password:
            credentials.password = text
            passwordValidator.password = text
            confirmPasswordValidator.password = text
        case .confirmPassword:
            credentials.confirmPassword = text
            confirmPasswordValidator.confirmPassword = text
        }
    }
    
    func signUp() {
        if validateForm() {
            guard let user = userManager.signUp(use: credentials) else {
                failSignUpDelegate?()
                return
            }
            successSignUpDelegate?(user)
            return
        }
        
        failValidationDelegate?(validationState)
    }
    
    func validateForm() -> Bool {
        validationState = [
            nameValidator.validate(),
            emailValidator.validate(),
            passwordValidator.validate(),
            confirmPasswordValidator.validate()
        ]
        
        return validationState.allSatisfy {
            if case ValidationResult.success(_) = $0 {
                return true
            }
            return false
        }
    }
    
    private func getError(by type: InputTypes) -> String? {
        let validationResult: ValidationResult?
        switch type {
        case .name:
            validationResult = validationState.first { $0.target == .name }
        case .email:
            validationResult = validationState.first { $0.target == .email }
        case .password:
            validationResult = validationState.first { $0.target == .password }
        case .confirmPassword:
            validationResult = validationState.first { $0.target == .confirmPassword }
        }
        
        return validationResult?.error
    }
}
