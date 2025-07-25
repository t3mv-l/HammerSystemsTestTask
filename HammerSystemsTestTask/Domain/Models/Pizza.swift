//
//  Pizza.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

struct Pizza: Identifiable {
    let id = UUID()
    let image: String
    let name: String
    let description: String
    let price: String
    let category: Category
}

enum Category: String, CaseIterable {
    case pizza = "Пицца"
    case combo = "Комбо"
    case desserts = "Десерты"
    case drinks = "Напитки"
}
