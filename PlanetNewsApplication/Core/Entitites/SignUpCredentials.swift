import Foundation

class SignUpCredentials {
    var email: String
    var password: String
    var confirmPassword: String
    var name: String
    
    init(name: String, email: String, password: String, confirmPassword: String){
        self.name = name
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
}
