//
//  MenuItem.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

protocol MenuItem: Identifiable {
    var id: UUID { get }
    var image: String { get }
    var name: String { get }
    var description: String { get }
    var price: String { get }
    var category: Category { get }
}

extension Pizza: MenuItem {}
extension Combo: MenuItem {}

struct Pizza: Identifiable {
    let id = UUID()
    let image: String
    let name: String
    let description: String
    let price: String
    let category: Category
}

struct Combo: Identifiable {
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
