//
//  APIClientError.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/04.
//

import Foundation

enum HTTPClientError: LocalizedError {
    /// The status code is outside the range of 100...599.
    case invalid
    /// The status code is informational (1xx) and the response is not final.
    case informational
    /// The status code is successful (2xx).
//    case successful
    /// The status code is a redirection (3xx).
    case redirection
    /// The status code is a client error (4xx).
    case clientError
    /// The status code is a server error (5xx).
    case serverError
}
