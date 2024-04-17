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
            throw APIError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpStatus = response as? HTTPURLResponse else {
            throw APIError.responseError
        }
        switch httpStatus.statusCode {
        case 100 ... 199:
            throw APIClientError.informational
        case 200 ..< 299:
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let responseData = try? jsonDecoder.decode(ItemsObject.self, from: data) else {
                throw APIError.decodeFailed
            }
            let itemsData = responseData.items
            return itemsData
        case 300 ..< 399:
            throw APIClientError.redirection
        case 400 ..< 499:
            throw APIClientError.clientError
        case 500 ..< 599:
            throw APIClientError.serverError
        default:
            throw APIClientError.invalid
        }
    }
    
    func fetchItemImgString(id: Int) -> String {
        let itemImg = "\(baseUrlString)/image/\(id)"
        return itemImg
    }
}
