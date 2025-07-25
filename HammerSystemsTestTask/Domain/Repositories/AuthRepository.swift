//
//  AuthRepository.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

protocol AuthRepository {
    func authenticate(credentials: User, completion: @escaping (Result<Bool, Error>) -> Void)
}
