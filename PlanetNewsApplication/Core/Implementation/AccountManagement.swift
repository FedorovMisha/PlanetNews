import Foundation

class AuthorizationService : Authorization {
    
    private var userManager: UserManager

    
    init(userManger: UserManager){
        self.userManager = userManger
    }
    
    func autoLogin() -> Bool {
        guard (userManager.currentUser) != nil else {
            return false
        }
    
        return true
    }
    
    func signIn(_ credentials: SignInCredentials) -> Bool {
        guard let user = userManager.getUser(credentials: credentials) else {
            return false
        }
        
        userManager.currentUser = user
        return true
    }
    
    func signUp(_ credentials: SignUpCredentials) -> Bool {
        
        guard (userManager.getUser(credentials: SignInCredentials(email: credentials.email, password: credentials.password))) == nil else{
            return false
        }
        
        guard (userManager.getUser(credentials: SignInCredentials(email: credentials.email, password: credentials.password))) == nil else {
            return false
        }
        
        guard (userManager.save(credentials: credentials)) != nil else {
            return false
        }
    
        return true
    }
    
    func logOut() {
        userManager.currentUser = nil
    }
    
    
    
}

