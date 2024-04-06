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
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems,
                    spacing: 20,
                    content: {
                    ForEach(viewModel.allItems) { item in
                        ShoppingCell(items: item)
                    }
                }
              )
            }
            .task { @MainActor in
                do {
                    let item = try await viewModel.fetchAllItems()
                    viewModel.allItems = item
                } catch {
                    print("⭐️\(error)")
                }
            }
            .navigationTitle("Hinakko's Market")
        }
        .padding()
    }
}

#Preview {
    ShoppingView()
}
