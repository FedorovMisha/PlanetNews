import UIKit

extension TextFieldViewCell {
    func configure(by type: SignInViewModel.InputType) {
        textField.attributedPlaceholder = NSAttributedString(string: type.placeholder, attributes: [.foregroundColor:ColorConstants.white])
        
        switch type {
        case .email:
            textField.isSecureTextEntry = false
        case .password:
            textField.isSecureTextEntry = true
        }
    }
}
