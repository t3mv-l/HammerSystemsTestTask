//
//  AuthLocalDataSource.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

protocol AuthLocalDataSource {
    func validate(credentials: UserDTO) -> Bool
}
