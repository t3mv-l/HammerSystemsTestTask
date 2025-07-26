//
//  MenuViewModel.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

class MenuViewModel: ObservableObject {
    @Published var selectedCategory: Category = .pizza
    @Published var menuItems: [any MenuItem] = []
    @Published var scrollToIndex: Int?
    @Published var isLoading = false
    
    private let menuUseCase: MenuUseCase
    
    init(menuUseCase: MenuUseCase) {
        self.menuUseCase = menuUseCase
        loadMenuItems()
    }
    
    func loadMenuItems() {
        isLoading = true
        
        let pizzas = menuUseCase.fetchPizzas()
        let combos = menuUseCase.fetchCombos()
        menuItems = pizzas + combos
        
        Task { [weak self] in
            guard let self = self else { return }
            
            let desserts = await menuUseCase.fetchDesserts()
            let drinks = await menuUseCase.fetchDrinks()
            
            await MainActor.run {
                self.menuItems += desserts + drinks
                self.isLoading = false
            }
        }
    }
    
    func scrollToCategory(_ category: Category) {
        selectedCategory = category
        scrollToIndex = menuItems.firstIndex(where: { $0.category == category })
    }
}
