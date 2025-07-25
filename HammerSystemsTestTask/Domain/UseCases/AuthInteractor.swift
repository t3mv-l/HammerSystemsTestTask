//
//  AuthInteractor.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

class AuthInteractor: AuthUseCase {
    private let authRepository: AuthRepository
        
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func login(credentials: User, completion: @escaping (Result<Bool, any Error>) -> Void) {
        authRepository.authenticate(credentials: credentials, completion: completion)
    }    
}
