//
//  MenuInteractor.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

class MenuInteractor: MenuUseCase {
    private let menuRepository: MenuRepository
        
    init(menuRepository: MenuRepository) {
        self.menuRepository = menuRepository
    }
        
    func fetchPizzas() -> [Pizza] {
        return menuRepository.getAllPizzas()
    }
    
    func fetchCombos() -> [Combo] {
        return menuRepository.getAllCombos()
    }    
}
