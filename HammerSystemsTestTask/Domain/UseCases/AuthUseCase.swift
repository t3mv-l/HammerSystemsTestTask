//
//  AuthUseCase.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

protocol AuthUseCase {
    func login(credentials: User, completion: @escaping (Result<Bool, Error>) -> Void)
}
