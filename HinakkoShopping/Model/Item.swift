//
//  Item.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/02.
//

struct ItemsObject: Codable {
    let items: [Items]
}

struct Items: Codable, Identifiable {
    let id: Int
    let name: String
    let category: String
    let imageName: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case category = "category"
        case imageName = "image_name"
    }

    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        category = try values.decode(String.self, forKey: .category)
        imageName = try values.decode(String.self, forKey: .imageName)
    }
}
