//
//  AuthorizationViewModel.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import SwiftUI

class AuthorizationViewModel: ObservableObject {
    @Published var login: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var showFailBanner: Bool = false
    @Published var isAuthorized: Bool = false
    
    private let authUseCase: AuthUseCase
    
    init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
    }
    
    func loginUser() {
        authUseCase.login(credentials: User(login: login, password: password)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let isSuccess):
                    self?.isAuthorized = isSuccess
                    if !isSuccess {
                        self?.showFailBanner = true
                        self?.hideBannerAfterDelay()
                    }
                case .failure:
                    self?.showFailBanner = true
                    self?.hideBannerAfterDelay()
                }
            }
        }
    }
    
    private func hideBannerAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.showFailBanner = false
            }
        }
    }
}
