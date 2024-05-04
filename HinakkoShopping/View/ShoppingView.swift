//
//  ContentView.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/02.
//

import SwiftUI

struct ShoppingView: View {
    private let gridItems: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var shoppingVM = ShoppingViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems,
                          spacing: 20,
                          content: {
                    ForEach(searchResults) { item in
                        ShoppingCell(item: item, shoppingVM: shoppingVM)
                    }
                }
                )
            }
            .overlay(alignment: .bottomTrailing) {
                Button(action: {
                    shoppingVM.showSheet = true
                }) {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.pink)
                        .frame(width: 80, height: 80)
                        .overlay {
                            VStack {
                                Image(systemName: "camera")
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundStyle(.white)
                                Text("出品")
                                    .foregroundStyle(.white)
                                    .font(.title2.bold())
                            }
                        }
                }
                .sheet(isPresented: $shoppingVM.showSheet, onDismiss: {
                    Task {
                        await shoppingVM.getAllitems()
                    }
                }) {
                    PostView()
                }
                .padding([.trailing, .bottom], 15)
            }
        }
        .task {
                await shoppingVM.getAllitems()
        }
        .searchable(text: $shoppingVM.searchText, prompt: "キーワード検索")
        .keyboardType(.default)
        .scrollDismissesKeyboard(.immediately)
    }
    
    var searchResults: [Item] {
        if shoppingVM.searchText.isEmpty {
            return shoppingVM.allItems
        } else {
            return shoppingVM.allItems.filter {
                $0.name.contains(shoppingVM.searchText)
            }
        }
    }
}

#Preview {
    ShoppingView()
}
