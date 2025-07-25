//
//  SplashViewModel.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import SwiftUI

class SplashViewModel: ObservableObject {
    @Published var showSplash = true
    
    func hideSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.showSplash = false
            }
        }
    }
}
