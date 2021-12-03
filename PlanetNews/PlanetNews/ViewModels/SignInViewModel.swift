import UIKit

class SignInViewModel {
    enum CellType {
        case input(InputType), submitButton, backButton
        var cellId: String {
            switch self {
            case .input:
                return TextFieldViewCell.id
            case .submitButton:
                return ButtonViewCell.id
            case .backButton:
                return TextButtonViewCell.id
            }
        }
        var height: Double {
            switch self {
            case .input(.password):
                return FlexSize.height(90)
            case .input:
                return FlexSize.height(70)
            case .submitButton:
                return FlexSize.height(80)
            case .backButton:
                return FlexSize.height(310)
            }
        }
    }
    enum InputType {
        case email, password
        
        var placeholder: String {
            switch self {
            case .email:
                return "Email"
            case .password:
                return "Password"
            }
        }
    }
    
    var credentials = SignInCredentials(email: "", password: "")
    var successSignInDelegate: (() -> Void)?
    var failSignInDelegate: (() -> Void)?
    var userManager: UserManagerProtocol = UserManager()
    
    func updateField(by type: InputType, text: String) {
        switch type {
        case .email:
            credentials.email = text
        case .password:
            credentials.password = text
        }
    }
    
    func signIn() {
        guard let _ = userManager.signIn(use: credentials) else {
            failSignInDelegate?()
            return
        }
        successSignInDelegate?()
    }
}
