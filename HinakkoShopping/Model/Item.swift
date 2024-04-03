//
//  Item.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/02.
//

import Foundation

struct Item: Decodable {
    let shoppingItem: [ShoppingItem]
}

struct ShoppingItem: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let imageName: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case category = "category"
        case imageName = "image_name"
    }

    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        category = try values.decode(String.self, forKey: .category)
        imageName = try values.decode(String.self, forKey: .imageName)
    }
}
