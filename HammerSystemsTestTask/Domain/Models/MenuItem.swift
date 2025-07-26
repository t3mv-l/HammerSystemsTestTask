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
extension MealItem: MenuItem {}

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

struct MealItem: Identifiable {
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
    
    var linkURL: String {
        switch self {
        case .desserts:
            return "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        case .drinks:
            return "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"
        default:
            return ""
        }
    }
}

struct DessertAPIResponse: Decodable {
    let meals: [Dessert]
}

struct Dessert: Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}

struct DrinkAPIResponse: Decodable {
    let drinks: [Drink]
}

struct Drink: Decodable {
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String
}
