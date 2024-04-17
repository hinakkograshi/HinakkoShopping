//
//  APIError.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/17.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case responseError
    case decodeFailed
}
