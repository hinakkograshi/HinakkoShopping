//
//  ContentView.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/02.
//

import SwiftUI

struct ShoppingView: View {
    private let gridItems: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems,
                    spacing: 20,
                    content: {
                    ForEach(0..<10) {_ in
                        ShoppingCell()
                    }



                })
                VStack {
                    Text("Hello, world!")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ShoppingView()
}
