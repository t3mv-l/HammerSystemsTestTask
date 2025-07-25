//
//  AuthLocalDataSourceImpl.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

class AuthLocalDataSourceImpl: AuthLocalDataSource {
    private let correctLogin = "Login"
    private let correctPassword = "Password"
    
    func validate(credentials: UserDTO) -> Bool {
        return credentials.login == correctLogin && credentials.password == correctPassword
    }    
}
