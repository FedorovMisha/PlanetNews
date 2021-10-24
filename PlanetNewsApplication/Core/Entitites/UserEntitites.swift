//
//  UserEntitites.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 24.10.2021.
//

import Foundation


class ApplicationUser : Codable {
    var name: String
    var email: String
    var password: String
    
    init(name: String, email: String, password: String){
        self.name = name
        self.email = email
        self.password = password
    }
    
    init(credentials: SignUpCredentials){
        self.name = credentials.name
        self.email = credentials.email
        self.password = credentials.password
    }
}


class SignInCredentials{
    var email: String
    var password: String
    init(email: String, password: String){
        self.email = email
        self.password = password
    }

}


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
