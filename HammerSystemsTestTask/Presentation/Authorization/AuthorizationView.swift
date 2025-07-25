//
//  AuthorizationView.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import SwiftUI

struct AuthorizationView: View {
    @ObservedObject var viewModel: AuthorizationViewModel
    var onLogin: () -> Void
    
    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()
            VStack {
                Text("Авторизация")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 16)
                        
                Spacer()
                        
                Image("Logo")
                    .scaledToFit()
                    .padding(.bottom, 40)
                        
                HStack {
                    Image("Person")
                        .foregroundStyle(.gray)
                    TextField("Логин", text: $viewModel.login)
                        .textInputAutocapitalization(.never)
                }
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                )
                .padding(.horizontal)
                        
                HStack {
                    Image("Lock")
                        .foregroundStyle(.gray)
                    Group {
                        if viewModel.isPasswordVisible {
                            TextField("Пароль", text: $viewModel.password)
                        } else {
                            SecureField("Пароль", text: $viewModel.password)
                        }
                    }
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .frame(height: 22)
                            
                    if !viewModel.password.isEmpty {
                        Button {
                            
                        } label: {
                            Image(viewModel.isPasswordVisible ? "EyeC" : "EyeO")
                                .foregroundStyle(.gray)
                        }
                        .buttonStyle(.plain)
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in viewModel.isPasswordVisible = true }
                                .onEnded { _ in viewModel.isPasswordVisible = false }
                        )
                    }
                }
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                )
                .padding(.horizontal)
                .padding(.top, 8)
                        
                Spacer()
                        
                ZStack {
                    Color.white
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .edgesIgnoringSafeArea(.bottom)
                    Button {
                        viewModel.loginUser()
                    } label: {
                        Text("Войти")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background((viewModel.login.isEmpty || viewModel.password.isEmpty) ? Color.pink.opacity(0.4) : Color("Splash"))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .disabled(viewModel.login.isEmpty || viewModel.password.isEmpty)
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
                .frame(height: 120)
            }
                    
            if viewModel.showFailBanner {
                VStack {
                    Spacer().frame(height: 4)
                    Image("Fail")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                    Spacer()
                }
            }
        }
        .animation(.easeInOut, value: viewModel.showFailBanner)
        .onChange(of: viewModel.isAuthorized) { _, isAuthorized in
            if isAuthorized {
                onLogin()
            }
        }
    }
}

