//
//  NameValidator.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 24.10.2021.
//

import Foundation


class NameValidator : Validator{
    
    private var userName: String?
    
    required init(userName: String?){
        self.userName = userName
    }
    
    func validate() -> ValidationResult {
        guard let name = userName, name.count > 0 else {
            return self.fail([.name: "Name is empty"])
        }

        return self.ok()
    }
}

