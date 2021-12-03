import Foundation

struct PasswordValidator: Validator {
    var password: String
    
    func validate() -> ValidationResult {
        guard password.count > 7 else {
            return .fail(.password, ErrorMessages.passwordIsShort)
        }
        return .success(.password)
    }
}
