//
//  MenuViewModel.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import Foundation

class MenuViewModel: ObservableObject {
    @Published var selectedCategory = 0
    @Published var offset: CGFloat = 0
    @Published var headerHeight: CGFloat = 0
    @Published var pizzas: [Pizza] = []
    
    private let menuUseCase: MenuUseCase
    
    init(menuUseCase: MenuUseCase) {
        self.menuUseCase = menuUseCase
        loadPizzas()
    }
    
    private func loadPizzas() {
        pizzas = menuUseCase.fetchPizzas()
    }
    
    func pizzas(for category: Category) -> [Pizza] {
        return pizzas.filter { $0.category == category }
    }
}
