//
//  Item.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/02.
//

struct Items: Decodable {
    let items: [Item]
}

struct Item: Decodable, Identifiable {
    let id: Int
    let name: String
    let category: String
}
