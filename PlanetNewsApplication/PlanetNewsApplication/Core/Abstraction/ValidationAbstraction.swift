import Foundation

enum ValidationErrorTypes {
    case email
    case password
    case name
    case confirmPassword
    case formLevel
}

typealias ValidationResult = (success: Bool, errors: [ValidationErrorTypes: String])

protocol Validator {
    func validate() -> ValidationResult
}
