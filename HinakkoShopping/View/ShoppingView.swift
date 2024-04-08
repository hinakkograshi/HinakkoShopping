//
//  ContentView.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/02.
//

import SwiftUI

struct ShoppingView: View {
    private let gridItems: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    @ObservedObject var viewModel = ShoppingViewModel()
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems,
                          spacing: 20,
                          content: {
                    ForEach(searchResults) { item in
                        ShoppingCell(items: item)
                    }
                }
                )
            }
        }
        .task { @MainActor in
            do {
                let item = try await viewModel.fetchAllItems()
                viewModel.allItems = item
            } catch {
                print("⭐️\(error)")
            }
        }
        .searchable(text: $searchText, prompt: "キーワード検索")
        .keyboardType(.default)
        .scrollDismissesKeyboard(.immediately)
    }

    var searchResults: [Items] {
        if searchText.isEmpty {
            return viewModel.allItems
        } else {
            return viewModel.allItems.filter {
                $0.name.contains(searchText)
            }
        }
    }
}

#Preview {
    ShoppingView()
}
