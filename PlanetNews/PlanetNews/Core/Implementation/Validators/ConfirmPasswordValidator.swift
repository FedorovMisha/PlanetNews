import Foundation

struct ConfirmPassworValidator: Validator {
    var password: String
    var confirmPassword: String
    
    func validate() -> ValidationResult {
        guard password == confirmPassword else {
            return .fail(.confirmPassword, ErrorMessages.confirmPasswordError)
        }
        
        return .success(.confirmPassword)
    }
}
