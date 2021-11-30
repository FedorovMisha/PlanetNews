import Foundation

protocol UserManagerProtocol {
    var currentUser: ApplicationUser? { get set }
    func signIn(use credentials: SignInCredentials) -> ApplicationUser?
    func signUp(use credentials: SignUpCredentials) -> ApplicationUser?
    func logOut()
}
