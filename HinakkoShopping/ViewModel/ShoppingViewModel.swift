//
//  ShoppingViewModel.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/02.
//

import SwiftUI

final class ShoppingViewModel: ObservableObject {
    @Published var allItems: [Items] = []
    let baseUrlString = "http://127.0.0.1:9000"
}

extension ShoppingViewModel {
    func fetchAllItems() async throws -> [Items] {
        let allItemsUrlString = "\(baseUrlString)/items"
        guard let url = URL(string: allItemsUrlString) else {
            throw APIClientError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpStatus = response as? HTTPURLResponse else {
            throw APIClientError.responseError
        }
        switch httpStatus.statusCode {
        case 200 ..< 400:
            guard let responseData = try? JSONDecoder().decode(ItemsObject.self, from: data) else {
                throw APIClientError.decodeFailed
            }
            let itemsData = responseData.items
            return itemsData
        case 400...:
            throw APIClientError.badStatus(statusCode: httpStatus.statusCode)
        default:
            throw APIClientError.badStatus(statusCode: httpStatus.statusCode)
        }
    }
    
    func fetchItemImgString(id: Int) -> String {
        let itemImg = "\(baseUrlString)/image/\(id)"
        return itemImg
    }
}
