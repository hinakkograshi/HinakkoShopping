//
//  ContentView.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/02.
//

import SwiftUI

struct ShoppingView: View {
    @State var showSheet = false
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
            .overlay(alignment: .bottomTrailing) {
                Button(action: {
                    showSheet = true
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
                .sheet(isPresented: $showSheet, onDismiss: {
                        Task {
                            do {
                                let item = try await viewModel.fetchAllItems()
                                viewModel.allItems = item
                            } catch {
                                print("⭐️\(error)")
                            }
                        }
                    }) {
                    PostView()
                }
                .padding([.trailing, .bottom], 15)
            }
        }
        .task {
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
