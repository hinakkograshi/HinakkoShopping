//
//  Item.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/02.
//

struct ItemsObject: Decodable {
    let items: [Items]
}

struct Items: Decodable, Identifiable {
    let id: Int
    let name: String
    let category: String
    let imageName: String
}
