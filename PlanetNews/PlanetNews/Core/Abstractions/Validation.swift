import Foundation

enum ValidationTarget {
    case email, name, password, confirmPassword, form
}

enum ValidationResult {
    case success(ValidationTarget), fail(ValidationTarget , String)
    
    var target: ValidationTarget {
        switch self {
        case .success(let validationTarget):
            return validationTarget
        case .fail(let validationTarget, _):
            return validationTarget
        }
    }
    var error: String? {
        switch self {
        case .success(_):
            return nil
        case .fail(_, let string):
            return string
        }
    }
}

protocol Validator {
    func validate() -> ValidationResult
}
