//
//  MenuRepository.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

protocol MenuRepository {
    func getAllPizzas() -> [Pizza]
    func getAllCombos() -> [Combo]
}

protocol MealRepository {
    func fetchMeals(category: Category) async throws -> [MealItem]
}
