//
//  MenuRepository.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

protocol MenuRepository {
    func getAllPizzas() -> [Pizza]
    func getPizzas(by category: Category) -> [Pizza]
}
