import Foundation

class ApplicationUser: Codable {
    var name: String
    var email: String
    var password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    init(credentials: SignUpCredentials) {
        self.name = credentials.name
        self.email = credentials.email
        self.password = credentials.password
    }
}
