import Foundation

struct EmailValidator: Validator {
    var email: String
    let emailPattern = #"^\S+@\S+\.\S+$"#
    
    func validate() -> ValidationResult {
        let emailRegex = try! NSRegularExpression(pattern: self.emailPattern, options: [])
        
        let emailRange = NSRange(email.startIndex..<email.endIndex, in: email)
        
        let regexResult = emailRegex.matches(in: email, options: [], range: emailRange)
        
        guard regexResult.count != 0 else {
            return .fail(.email, "Invalid email")
        }
        
        return .success(.email)
    }
}
