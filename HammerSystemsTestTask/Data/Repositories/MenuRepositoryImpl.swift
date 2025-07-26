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

class MealRepositoryImpl: MealRepository {
    func fetchMeals(category: Category) async throws -> [MealItem] {
        guard let url = URL(string: category.linkURL) else { return [] }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            switch category {
                case .desserts:
                    let response = try JSONDecoder().decode(DessertAPIResponse.self, from: data)
                    return response.meals.prefix(4).map { dessert in
                        return MealItem(
                            image: dessert.strMealThumb,
                            name: translateDessertOrDrinkName(dessert.strMeal),
                            description: getDescriptionForMeal(dessert.strMeal, category: category),
                            price: generatePriceForCategory(category),
                            category: category
                        )
                    }
                            
                case .drinks:
                    let response = try JSONDecoder().decode(DrinkAPIResponse.self, from: data)
                    return response.drinks.prefix(4).map { drink in
                        return MealItem(
                            image: drink.strDrinkThumb,
                            name: translateDessertOrDrinkName(drink.strDrink),
                            description: getDescriptionForMeal(drink.strDrink, category: category),
                            price: generatePriceForCategory(category),
                            category: category
                        )
                    }
                            
                default:
                    return []
                }
        } catch {
            return []
        }
    }
    
    private func translateDessertOrDrinkName(_ englishName: String) -> String {
        let translations = [
                    "Apam balik": "Апам балик",
                    "Apple & Blackberry Crumble": "Яблочно-ежевичный крамбл",
                    "Apple Frangipan Tart": "Яблочный пирог с франжипаном",
                    "Bakewell tart": "Пирог по-Бейквелльски",
                    "Alice Cocktail": "От Алисы",
                    "Apello": "Апелло"
                ]
        return translations[englishName] ?? englishName
    }
    
    private func getDescriptionForMeal(_ name: String, category: Category) -> String {
        switch category {
        case .desserts: return "Вкусный десерт: \(translateDessertOrDrinkName(name))"
        case .drinks: return "Освежающий коктейль: \(translateDessertOrDrinkName(name))"
        default: return ""
        }
    }
        
    private func generatePriceForCategory(_ category: Category) -> String {
        switch category {
        case .desserts: return "от 250 ₽"
        case .drinks: return "от 150 ₽"
        default: return ""
        }
    }
}
