//
//  MainView.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            MenuView(viewModel: MenuViewModel(menuUseCase: viewModel.menuUseCase))
                .tabItem { Image("Menu") }
                .tag(0)
            
            ContactsView()
                .tabItem { Image("Contacts") }
                .tag(1)
            
            ProfileView()
                .tabItem { Image("Profile") }
                .tag(2)
            
            CartView()
                .tabItem { Image("Cart") }
                .tag(3)
        }
        .toolbarBackground(Color(.systemBackground), for: .tabBar)
        .overlay(
            viewModel.showSuccessBanner ?
            VStack {
                Spacer().frame(height: 4)
                Image("Success")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                Spacer()
            } : nil
        )
        .animation(.easeInOut, value: viewModel.showSuccessBanner)
    }
}
