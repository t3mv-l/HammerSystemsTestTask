//
//  AuthRepositoryImpl.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

class AuthRepositoryImpl: AuthRepository {
    private let localDataSource: AuthLocalDataSource
    
    init(localDataSource: AuthLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    func authenticate(credentials: User, completion: @escaping (Result<Bool, any Error>) -> Void) {
        let isValid = localDataSource.validate(credentials: UserDTO(login: credentials.login, password: credentials.password))
        completion(.success(isValid))
    }    
}
