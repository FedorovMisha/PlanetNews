import Foundation

struct NameValidator: Validator {
    var name: String
    
    func validate() -> ValidationResult {
        guard name.count > 4 else {
            return .fail(.name, ErrorMessages.nameIsShort)
        }
        return .success(.name)
    }
}
