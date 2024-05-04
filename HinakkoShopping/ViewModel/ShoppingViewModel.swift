//
//  ShoppingViewModel.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/02.
//

import SwiftUI

@MainActor
final class ShoppingViewModel: ObservableObject {
    @Published var allItems = [Item]()
    @Published var showSheet = false
    @Published var searchText = ""
    func getAllitems() async {
        do {
                self.allItems = try await APIClient.fetchAllItems()
        } catch {
            print("error")
        }
    }
    func getItemImg(id: Int) throws -> URL {
            let itemImgURL = try APIClient.fetchItemImgString(id: id)
            return itemImgURL
    }
}
