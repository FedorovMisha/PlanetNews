//
//  ValidationExtension.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 24.10.2021.
//

import Foundation


extension Validator{
    func ok() -> ValidationResult{
        return (true, [:])
    }
    
    func fail(_ errors: [ValidationErrorTypes : String]) -> ValidationResult{
        return (false, errors)
    }
}
