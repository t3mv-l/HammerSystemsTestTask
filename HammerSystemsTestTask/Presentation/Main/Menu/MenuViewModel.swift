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
    
    private let menuUseCase: MenuUseCase
    
    init(menuUseCase: MenuUseCase) {
        self.menuUseCase = menuUseCase
        loadMenuItems()
    }
    
    private func loadMenuItems() {
        let pizzas = menuUseCase.fetchPizzas()
        let combos = menuUseCase.fetchCombos()
        menuItems = pizzas + combos
    }
    
    func scrollToCategory(_ category: Category) {
        selectedCategory = category
        scrollToIndex = menuItems.firstIndex(where: { $0.category == category })
    }
}
