import Foundation

extension Validator{
    func success() -> ValidationResult {
        return (true, [:])
    }
    
    func fail(_ errors: [ValidationErrorTypes : String]) -> ValidationResult {
        return (false, errors)
    }
}
