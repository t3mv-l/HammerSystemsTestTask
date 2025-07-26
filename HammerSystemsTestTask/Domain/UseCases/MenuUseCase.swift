//
//  MenuUseCase.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

protocol MenuUseCase {
    func fetchPizzas() -> [Pizza]
    func fetchCombos() -> [Combo]
}
