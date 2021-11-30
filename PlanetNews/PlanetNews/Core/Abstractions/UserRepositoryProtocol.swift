import Foundation

protocol UserRepositoryPrototcol {
    func find(where predicate: (ApplicationUser) -> Bool) -> ApplicationUser?
    func create(user: ApplicationUser) -> Bool
    func getAll() -> [ApplicationUser]
    func getCurrentUser() -> ApplicationUser?
    func setCurrentUser(user: ApplicationUser)
    func removeCurrentUser()
}
