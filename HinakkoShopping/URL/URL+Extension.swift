//
//  URL+Extension.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/30.
//

import Foundation

extension URL {

    static func forAllItems() -> URL? {
        return URL(string: "http://127.0.0.1:9000/items")
    }

    static func forItemImg(id: Int) -> URL? {
        return URL(string: "http://127.0.0.1:9000/image/\(id)")
    }
}
