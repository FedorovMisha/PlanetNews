//
//  AccountManagement.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 24.10.2021.
//

import Foundation


class AuthenticationService : Authentication{
    
    private let userManager: UserManager
    
    init(userManager: UserManager){
        self.userManager = userManager
    }
    
    func authenticate(credentials: SignInCredentials) -> ApplicationUser? {
        return userManager.getUser(credentials: credentials)
    }
}


class AuthorizationService : Authorization {
    
    private var userManager: UserManager
    
    private var authenticationService: Authentication
    
    init(userManger: UserManager, authenticationService: Authentication){
        self.userManager = userManger
        self.authenticationService = authenticationService
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
        
        guard (authenticationService.authenticate(credentials: SignInCredentials(email: credentials.email, password: credentials.password))) == nil else {
            return false
        }
        
        guard (userManager.save(credentials: credentials)) != nil else {
            return false
        }
    
        return true
    }
    
    func logOut() -> Bool {
        userManager.currentUser = nil
        return true
    }
    
    
    
}

