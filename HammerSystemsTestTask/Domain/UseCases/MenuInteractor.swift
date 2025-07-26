//
//  MenuInteractor.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

class MenuInteractor: MenuUseCase {
    private let menuRepository: MenuRepository
    private let mealRepository: MealRepository
        
    init(menuRepository: MenuRepository, mealRepository: MealRepository) {
        self.menuRepository = menuRepository
        self.mealRepository = mealRepository
    }
        
    func fetchPizzas() -> [Pizza] {
        return menuRepository.getAllPizzas()
    }
    
    func fetchCombos() -> [Combo] {
        return menuRepository.getAllCombos()
    }
    
    func fetchDesserts() async -> [MealItem] {
        do {
            return try await mealRepository.fetchMeals(category: .desserts)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func fetchDrinks() async -> [MealItem] {
        do {
            return try await mealRepository.fetchMeals(category: .drinks)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
