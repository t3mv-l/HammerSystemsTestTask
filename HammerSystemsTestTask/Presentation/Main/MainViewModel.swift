//
//  MainViewModel.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var selectedTab = 0
    @Published var showSuccessBanner = false
    
    let authUseCase: AuthUseCase
    let menuUseCase: MenuUseCase
    
    init(authUseCase: AuthUseCase, menuUseCase: MenuUseCase) {
        self.authUseCase = authUseCase
        self.menuUseCase = menuUseCase
        showWelcomeBanner()
    }
    
    private func showWelcomeBanner() {
        showSuccessBanner = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.showSuccessBanner = false
            }
        }
    }
}
