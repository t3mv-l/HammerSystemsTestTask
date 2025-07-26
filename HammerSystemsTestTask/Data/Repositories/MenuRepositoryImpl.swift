//
//  MenuRepositoryImpl.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

class MenuRepositoryImpl: MenuRepository {
    private let localDataSource: MenuLocalDataSource
    
    init(localDataSource: MenuLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    func getAllPizzas() -> [Pizza] {
        return localDataSource.fetchPizzas()
    }
    
    func getAllCombos() -> [Combo] {
        return localDataSource.fetchCombos()
    }
}
