//
//  MenuView.swift
//  HammerSystemsTestTask
//
//  Created by Артём on 25.07.2025.
//

import SwiftUI

struct MenuView: View {
    @State private var scrollOffset: CGFloat = 0
    private let bannerHeight: CGFloat = 125
    private let categoryBarHeight: CGFloat = 50
    private let cityHeaderHeight: CGFloat = 60
    
    @StateObject private var viewModel: MenuViewModel
    
    init(menuUseCase: MenuUseCase) {
        _viewModel = StateObject(wrappedValue: MenuViewModel(menuUseCase: menuUseCase))
    }
    
    private var cityName: some View {
        HStack {
            Text("Москва")
                .font(.title2).fontWeight(.medium)
            Image(systemName: "chevron.down")
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 16)
    }
    
    private var banners: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                Image("Banner")
                    .resizable()
                    .aspectRatio(2.5, contentMode: .fit)
                    .frame(height: bannerHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Image("Banner2")
                    .resizable()
                    .aspectRatio(2.5, contentMode: .fit)
                    .frame(height: bannerHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal)
            .padding(.top, 16)
        }
        .padding(.bottom, 16)
    }
    
    private var categoryButton: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Category.allCases, id: \.self) { category in
                    Button(action: { viewModel.scrollToCategory(category) }) {
                        Text(category.rawValue)
                            .fontWeight(.medium)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 15)
                            .background(viewModel.selectedCategory == category ? Color.pink.opacity(0.2) : Color.clear)
                            .foregroundStyle(viewModel.selectedCategory == category ? .pink : .gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color.pink, lineWidth: viewModel.selectedCategory == category ? 0 : 1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .lineLimit(1)
                    }
                }
            }
            .padding(.horizontal)
            .frame(height: categoryBarHeight)
        }
        .background(Color(.systemGray6))
    }
    
    private func menuItemRow(_ item: any MenuItem, isFirst: Bool) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 24) {
                AsyncImage(url: URL(string: item.image)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else if phase.error != nil {
                        Image(item.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 133, height: 133)
                .clipShape(Circle())
                .padding(.leading, 16)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.name)
                        .font(.title3).fontWeight(.semibold)
                        .minimumScaleFactor(0.8)
                    
                    Text(item.description)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                        .truncationMode(.tail)
                        .padding(.trailing, 16)
                    
                    HStack {
                        Spacer()
                        Text(item.price)
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
            .padding(.top, 16)
            .padding(.bottom)
            .background(Color.white)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.all)
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
    
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            Color.clear
                                .frame(height: cityHeaderHeight)
                            banners
                            categoryButton
                                .padding(.bottom)
                            
                            VStack(spacing: 0) {
                                ForEach(viewModel.menuItems.indices, id: \.self) { index in
                                    let item = viewModel.menuItems[index]
                                    menuItemRow(item, isFirst: index == 0)
                                        .id(index)
                                    
                                    if index < viewModel.menuItems.count - 1 {
                                        Divider()
                                            .frame(height: 1)
                                    }
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            
                        }
                        .background(
                            GeometryReader { proxy in
                                Color.clear
                                    .preference(key: ScrollOffsetKey.self, value: proxy.frame(in: .named("scroll")).minY)
                            }
                        )
                        .onChange(of: viewModel.scrollToIndex) { _, index in
                            if let index = index {
                                withAnimation {
                                    proxy.scrollTo(index, anchor: .center)
                                }
                                DispatchQueue.main.async {
                                    viewModel.scrollToIndex = nil
                                }
                            }
                        }
                    }
                    .coordinateSpace(name: "scroll")
                }
    
                VStack(spacing: 0) {
                    cityName
                        .padding(.bottom)
    
                    if scrollOffset < -bannerHeight * 1.3 {
                        categoryButton
                            .padding(.bottom)
                    }
                }
                .offset(y: scrollOffset < 0 ? 0 : -scrollOffset)
                .zIndex(1)
                .background(Color(.systemGray6))
            }
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                scrollOffset = value
            }
        }
    }
}
    
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
