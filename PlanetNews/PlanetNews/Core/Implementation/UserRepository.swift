import Foundation

class UserRepository: UserRepositoryPrototcol {
    private let usersStorageKey = "user-storage"
    private let currentUserKey = "current-user"
    private let storage = UserDefaults.standard
    let jsonManager: JsonManagerProtocol = JsonManager()
    
    
    func find(where predicate: (ApplicationUser) -> Bool) -> ApplicationUser? {
        let users = self.getAll()
        
        return users.first {
            predicate($0)
        }
    }
    
    func create(user: ApplicationUser) -> Bool {
        var users = getAll()
        users.append(user)
        guard let json = jsonManager.serialize(users) else {
            return false
        }
        storage.set(json, forKey: usersStorageKey)
        return true
    }
    
    func getAll() -> [ApplicationUser] {
        guard let json = storage.string(forKey: usersStorageKey) else {
            return []
        }
        
        guard let users:[ApplicationUser] = jsonManager.desirialize(json) else {
            return []
        }
        
        return users
    }
    
    func getCurrentUser() -> ApplicationUser? {
        guard let json = storage.string(forKey: currentUserKey) else {
            return nil
        }
        
        return jsonManager.desirialize(json)
    }
    
    func setCurrentUser(user: ApplicationUser) {
        guard let json = jsonManager.serialize(user) else { return }
        storage.set(json, forKey: currentUserKey)
    }
    
    func removeCurrentUser() {
        storage.removeObject(forKey: currentUserKey)
    }
    
}
