//
//  EmailValidator.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 24.10.2021.
//

import Foundation


class EmailValidator : Validator{
    
    private var email: String?
    private var emailPattern = #"^\S+@\S+\.\S+$"#
    
    required init(email: String?){
        self.email = email
    }
    
    func validate() -> ValidationResult {
        guard let email = email else {
            return self.fail([.email: "Email is empty"])
        }
        
        let emailRegex = try! NSRegularExpression(pattern: self.emailPattern, options: [])
        
        let emailRange = NSRange(email.startIndex..<email.endIndex, in: email)
        
        let regexResult = emailRegex.matches(in: email, options: [], range: emailRange)
        
        guard regexResult.count != 0 else {
            return self.fail([.email: "Incorret email"])
        }
        
        return self.ok()
    }
}
