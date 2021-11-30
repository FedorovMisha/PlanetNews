import Foundation

class UserManager: UserManagerProtocol {
    var userRepository: UserRepositoryPrototcol = UserRepository()
    var currentUser: ApplicationUser? {
        get {
            userRepository.getCurrentUser()
        }
        set {
            if let user = newValue {
                userRepository.setCurrentUser(user: user)
            } else {
                userRepository.removeCurrentUser()
            }
        }
    }
    
    func signIn(use credentials: SignInCredentials) -> ApplicationUser? {
        logOut()
        let user = userRepository.find {
            $0.email == credentials.email &&
            $0.password == credentials.password
        }
        guard let user = user else {
            return nil
        }
        
        self.currentUser = user
        
        return user
    }
    
    func signUp(use credentials: SignUpCredentials) -> ApplicationUser? {
        guard userRepository.find(where: { $0.email == credentials.email }) == nil else {
            return nil
        }
        
        let newUser = ApplicationUser(name: credentials.name, email: credentials.email, password: credentials.password)
        
        guard userRepository.create(user: newUser) else {
            return nil
        }
        
        return self.signIn(use: SignInCredentials(email: newUser.email, password: newUser.password))
    }
    
    func logOut() {
        self.currentUser = nil
    }
    
}
