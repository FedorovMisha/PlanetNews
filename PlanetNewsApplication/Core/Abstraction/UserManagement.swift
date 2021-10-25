//
//  UserManager.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 24.10.2021.
//

import Foundation


protocol UserManager{
    var currentUser: ApplicationUser? { get set }
    func save(credentials: SignUpCredentials) -> ApplicationUser?
    func getUser(credentials: SignInCredentials) -> ApplicationUser?
}

//protocol Authentication {
//    func authenticate(credentials: SignInCredentials) -> ApplicationUser?
//}

protocol Authorization {
    func autoLogin() -> Bool
    func signIn(_ credentials: SignInCredentials) -> Bool
    func signUp(_ credentials: SignUpCredentials) -> Bool
    func logOut()
}
