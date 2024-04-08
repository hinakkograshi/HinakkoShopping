//
//  ContentView.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/08.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTag = 1
    var body: some View {
        TabView(selection: $selectedTag) {
            ShoppingView()
                .tabItem {
                    Label("HOME", systemImage: "house")
                }.tag(1)
            ExhibitView()
                .tabItem {
                    Label("出品", systemImage: "camera")
                }.tag(2)
        }
    }
}

#Preview {
    ContentView()
}
