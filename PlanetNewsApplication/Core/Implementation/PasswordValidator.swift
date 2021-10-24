//
//  ValidationImplementation.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 24.10.2021.
//

import Foundation


class PasswordValidator : Validator {
    
    private var password: String?
    
    required init(password: String?){
        self.password = password
    }
    
    func validate() -> ValidationResult {
        guard let password = password else {
            return self.fail([.password : "Password is empty"])
        }
        
        guard password.count > 7 else {
            return self.fail([.password: "Password len must be great than 7"])
        }
        
        return self.ok()
    }
}


class ConfirmPasswordValidator : Validator {
    
    private var password: String?
    private var confirmPassword: String?
    
    required init(password: String?, confirmPassword: String?){
        self.password = password
        self.confirmPassword = confirmPassword
    }
    
    func validate() -> ValidationResult {
        
//        guard password else {
//            return self.ok()
//        }
//
//
//        guard let confirmPassword = confirmPassword else {
//            return self.fail([.confirmPassword: "Confirm password is empty"])
//        }

        guard password == confirmPassword else {
            return self.fail([.confirmPassword:"Confirm password is incorrect"])
        }
        return self.ok()
    }
}
