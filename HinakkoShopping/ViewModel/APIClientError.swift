//
//  APIClientError.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/04.
//

import Foundation

enum APIClientError: LocalizedError {
    case invalidURL
    case noData
    case responseError
    case badStatus(statusCode: Int)
    case networkError
    case decodeFailed
}
