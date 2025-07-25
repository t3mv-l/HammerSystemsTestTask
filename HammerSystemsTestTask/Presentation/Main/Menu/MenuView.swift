//
//  MenuView.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var viewModel: MenuViewModel
    private let categories = Category.allCases
    
    // Extracted pizza list view for better compilation
    private var pizzaList: some View {
        List {
            ForEach(Array(viewModel.pizzas.enumerated()), id: \.element.id) { index, pizza in
                pizzaRow(pizza: pizza, isFirst: index == 0)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                
                if index < viewModel.pizzas.count - 1 {
                    Divider()
                        .frame(height: 1)
                        .listRowInsets(EdgeInsets())
                }
            }
        }
        .listStyle(.plain)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
    
    // Extracted pizza row view
    private func pizzaRow(pizza: Pizza, isFirst: Bool) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 24) {
                Image(pizza.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 133, height: 133)
                    .clipShape(Circle())
                    .padding(.leading, 16)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(pizza.name)
                        .font(.title3).fontWeight(.semibold)
                        .minimumScaleFactor(0.8)
                    
                    Text(pizza.description)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                        .truncationMode(.tail)
                        .padding(.trailing, 16)
                    
                    HStack {
                        Spacer()
                        Text(pizza.price)
                            .font(.subheadline)
                            .foregroundStyle(.pink)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.pink, lineWidth: 1)
                            )
                    }
                    .padding(.trailing, 20)
                }
            }
            .padding(.top, isFirst ? 16 : 0)
            .padding(.bottom)
            .background(Color.white)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // City and banners section
            VStack {
                HStack {
                    Text("Москва")
                        .font(.title2).fontWeight(.medium)
                    Image(systemName: "chevron.down")
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                // Banners
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        Image("Banner")
                            .resizable()
                            .aspectRatio(2.5, contentMode: .fit)
                            .frame(height: 125)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Image("Banner2")
                            .resizable()
                            .aspectRatio(2.5, contentMode: .fit)
                            .frame(height: 125)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                }
                .padding(.bottom, 16)
            }
            
            // Categories
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(categories.enumerated()), id: \.offset) { index, category in
                        Button(action: { viewModel.selectedCategory = index }) {
                            Text(category.rawValue)
                                .fontWeight(.medium)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 15)
                                .background(viewModel.selectedCategory == index ? Color.pink.opacity(0.2) : Color.clear)
                                .foregroundStyle(viewModel.selectedCategory == index ? .pink : .gray)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color.pink, lineWidth: viewModel.selectedCategory == index ? 0 : 1)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .lineLimit(1)
                        }
                    }
                }
                .padding(.horizontal)
                .frame(height: 48)
            }
            .background(Color(.systemGray6))
            
            Spacer().frame(height: 24)
            
            // Pizza list
            pizzaList
        }
        .background(Color(.systemGray6))
    }
}

//import SwiftUI
//
//struct MenuView: View {
//    @ObservedObject var viewModel: MenuViewModel
//    private let categories = Category.allCases
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            VStack {
//                HStack {
//                    Text("Москва")
//                        .font(.title2).fontWeight(.medium)
//                    Image(systemName: "chevron.down")
//                    Spacer()
//                }
//                .padding(.horizontal)
//                .padding(.top, 16)
//                        
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 20) {
//                        Image("Banner")
//                            .resizable()
//                            .aspectRatio(2.5, contentMode: .fit)
//                            .frame(height: 125)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                                
//                        Image("Banner2")
//                            .resizable()
//                            .aspectRatio(2.5, contentMode: .fit)
//                            .frame(height: 125)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//                    .padding(.horizontal)
//                    .padding(.top, 16)
//                }
//                .padding(.bottom, 16)
//            }
//                    
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 12) {
//                    ForEach(categories.indices, id: \.self) { idx in
//                        Button(action: { viewModel.selectedCategory = idx }) {
//                            Text(categories[idx])
//                                .fontWeight(.medium)
//                                .padding(.vertical, 8)
//                                .padding(.horizontal, 15)
//                                .background(viewModel.selectedCategory == idx ? Color.pink.opacity(0.2) : Color.clear)
//                                .foregroundStyle(viewModel.selectedCategory == idx ? .pink : .gray)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 24)
//                                        .stroke(Color.pink, lineWidth: viewModel.selectedCategory == idx ? 0 : 1)
//                                )
//                                .clipShape(RoundedRectangle(cornerRadius: 20))
//                                .lineLimit(1)
//                                .fixedSize()
//                        }
//                    }
//                }
//                .padding(.horizontal)
//                .frame(height: 48)
//            }
//            .background(Color(.systemGray6))
//                    
//            Spacer().frame(height: 24)
//                    
//            List {
//                ForEach(viewModel.pizzas.indices, id: \.self) { idx in
//                    VStack(alignment: .leading, spacing: 12) {
//                        HStack(alignment: .center, spacing: 24) {
//                            Image(viewModel.pizzas[idx].image)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 133, height: 133)
//                                .clipShape(Circle())
//                                .padding(.leading, 16)
//                                    
//                            VStack(alignment: .leading, spacing: 8) {
//                                Text(viewModel.pizzas[idx].name)
//                                    .font(.title3).fontWeight(.semibold)
//                                    .minimumScaleFactor(0.8)
//                                        
//                                Text(viewModel.pizzas[idx].description)
//                                    .font(.subheadline)
//                                    .foregroundStyle(.gray)
//                                    .fixedSize(horizontal: false, vertical: true)
//                                    .truncationMode(.tail)
//                                    .padding(.trailing, 16)
//                                        
//                                HStack {
//                                    Spacer()
//                                    Text(viewModel.pizzas[idx].price)
//                                        .font(.subheadline)
//                                        .foregroundStyle(.pink)
//                                        .padding(.vertical, 8)
//                                        .padding(.horizontal, 16)
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 6)
//                                                .stroke(Color.pink, lineWidth: 1)
//                                        )
//                                        .lineLimit(1)
//                                        .fixedSize(horizontal: true, vertical: false)
//                                }
//                                .padding(.trailing, 20)
//                            }
//                        }
//                        .padding(.top, idx == 0 ? 16 : 0)
//                        .padding(.bottom)
//                        .background(Color.white)
//                        .listRowInsets(EdgeInsets())
//                        .listRowSeparator(.hidden)
//                    }
//                    .listRowInsets(EdgeInsets())
//                    .listRowSeparator(.hidden)
//                    if idx < viewModel.pizzas.count - 1 {
//                        Divider()
//                            .frame(height: 1)
//                            .listRowInsets(EdgeInsets())
//                    }
//                }
//            }
//            .listStyle(.plain)
//            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//        }
//        .background(Color(.systemGray6))
//    }
//}
