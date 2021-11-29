import Foundation

struct NameValidator: Validator {
    var name: String
    
    func validate() -> ValidationResult {
        guard name.count > 4 else {
            return .fail(.name, "Name is short")
        }
        return .success(.name)
    }
}
