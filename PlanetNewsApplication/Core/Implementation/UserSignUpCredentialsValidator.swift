import Foundation


class SignUpCredentialsValidator : Validator {
    
    private var emailValidator: Validator
    private var passwordValidator: Validator
    private var confirmPasswordValidator: Validator
    private var nameValidator: Validator
    private var credentials: SignUpCredentials
    
    
    required init(_ credentials: SignUpCredentials, emailValidator: Validator, passwordValidator: Validator, confirmPasswordValidator: Validator, nameValidator: Validator){
        self.nameValidator = nameValidator
        self.emailValidator = emailValidator
        self.confirmPasswordValidator = confirmPasswordValidator
        self.passwordValidator = passwordValidator
        self.credentials = credentials
    }
    
    func validate() -> ValidationResult {
        
        let results = [
            emailValidator.validate(),
            passwordValidator.validate(),
            nameValidator.validate(),
            confirmPasswordValidator.validate()
        ]
        
        let isSuccess = results.allSatisfy { (success: Bool, errors: [ValidationErrorTypes : String]) in
            success
        }
        
        guard !isSuccess else {
            return self.ok()
        }
        
        var errorMessage: String = ""
        
        for result in results {
            for error in result.errors{
                errorMessage.append(error.value + "\n")
            }
        }
        
        return self.fail([.formLevel: errorMessage])
    }
}
