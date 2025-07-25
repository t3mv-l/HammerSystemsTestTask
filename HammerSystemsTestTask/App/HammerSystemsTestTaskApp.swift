//
//  HammerSystemsTestTaskApp.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 23.07.2025.
//

import SwiftUI

@main
struct HammerSystemsTestTaskApp: App {
    @StateObject private var splashViewModel = SplashViewModel()
    @StateObject private var authViewModel = AuthorizationViewModel(
        authUseCase: Dependencies.shared.authUseCase
    )
        
    var body: some Scene {
        WindowGroup {
            ZStack {
                if splashViewModel.showSplash {
                    SplashView()
                        .transition(.opacity)
                        .zIndex(1)
                } else {
                    if authViewModel.isAuthorized {
                        MainView(
                            viewModel: MainViewModel(
                                authUseCase: Dependencies.shared.authUseCase,
                                menuUseCase: Dependencies.shared.menuUseCase
                            )
                        )
                        .transition(.move(edge: .trailing))
                    } else {
                        AuthorizationView(viewModel: authViewModel) {
                            authViewModel.isAuthorized = true
                        }
                            .transition(.move(edge: .leading))
                    }
                }
            }
            .animation(.easeInOut, value: splashViewModel.showSplash)
            .onAppear {
                splashViewModel.hideSplash()
            }
        }
    }
}
