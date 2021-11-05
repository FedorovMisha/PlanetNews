import Foundation

extension Validator{
    func ok() -> ValidationResult{
        return (true, [:])
    }
    
    func fail(_ errors: [ValidationErrorTypes : String]) -> ValidationResult{
        return (false, errors)
    }
}
