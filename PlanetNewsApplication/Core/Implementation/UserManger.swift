//
//  UserManger.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 24.10.2021.
//

import Foundation

class UserManagerService : UserManager{
    
    private let storage = UserDefaults.standard
    
    private let jsonEncoder = JSONEncoder()
    
    private let jsonDecoder = JSONDecoder()
    
    var currentUser: ApplicationUser? {
        get{
            guard let jsonUser = storage.string(forKey: "currentUser") else {
                return nil
            }
            guard let data = jsonUser.data(using: .utf8) else {
                return nil
            }
            return try? jsonDecoder.decode(ApplicationUser.self, from: data)
        }
        
        set {
            guard let user = newValue else {
                storage.removeObject(forKey: "currentUser")
                print("User was deleted")
                return
            }
            
            guard let jsonData = try? jsonEncoder.encode(user) else{
                return
            }
            guard let json = String(data: jsonData, encoding: .utf8) else {
                return
            }
            
            storage.set(json, forKey: "currentUser")
        }
    }
    
    
    func save(credentials: SignUpCredentials) -> ApplicationUser? {
        let user = ApplicationUser(credentials:  credentials)
        
        var users = getUsers()
        users.append(user)
        
        if let jsonData = try? jsonEncoder.encode(users) {
            guard let json = String(data: jsonData, encoding: .utf8) else {
                return nil
            }
            storage.set(json, forKey: "planetNews_Users")
            return user
        }
        
        return nil
    }
    
    func getUser(credentials: SignInCredentials) -> ApplicationUser? {
        let users = getUsers()
        
        guard users.count != 0 else {
            return nil
        }
        
        let user = users.first(where: { user in
            user.email == credentials.email && user.password == credentials.password
        })
        return user
    }
    
    private func getUsers() -> [ApplicationUser] {
        if let users = storage.string(forKey: "planetNews_Users"){
            guard let jsonData = users.data(using: .utf8) else {
                return []
            }
            guard let json = try? jsonDecoder.decode([ApplicationUser].self, from: jsonData) else {
                return []
            }
            
            return json
        }
        
        return []
    }
}
