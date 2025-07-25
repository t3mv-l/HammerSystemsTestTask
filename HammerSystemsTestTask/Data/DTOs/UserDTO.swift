//
//  UserDTO.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

struct UserDTO {
    let login: String
    let password: String
    
    func toDomain() -> User {
        return User(login: login, password: password)
    }
}
