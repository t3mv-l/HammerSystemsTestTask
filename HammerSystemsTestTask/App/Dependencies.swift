//
//  Dependencies.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

class Dependencies {
    static let shared = Dependencies()
    
    private init() {}
    
    // MARK: - Data Sources
    lazy var authLocalDataSource: AuthLocalDataSource = AuthLocalDataSourceImpl()
    lazy var menuLocalDataSource: MenuLocalDataSource = MenuLocalDataSourceImpl()
    
    // MARK: - Repositories
    lazy var authRepository: AuthRepository = AuthRepositoryImpl(localDataSource: authLocalDataSource)
    lazy var menuRepository: MenuRepository = MenuRepositoryImpl(localDataSource: menuLocalDataSource)
    
    // MARK: - Use Cases
    lazy var authUseCase: AuthUseCase = AuthInteractor(authRepository: authRepository)
    lazy var menuUseCase: MenuUseCase = MenuInteractor(menuRepository: menuRepository)
}
