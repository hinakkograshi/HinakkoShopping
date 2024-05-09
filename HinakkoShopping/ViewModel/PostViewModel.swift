//
//  PostViewModel.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/09.
//

import SwiftUI
import Alamofire

@MainActor
final class PostViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var itemName = ""
    @Published var categoryName = ""
    @Published var showingImagePicker = false
    func upLoad(name: String, category: String, image: UIImage, success: @escaping () -> Void, failure: @escaping () -> Void) {
        APIClient().upLoad(name: name, category: category, image: image, success: success, failure: failure)
    }
    func didTappedPostButtan(completionHandler: @escaping () -> Void) {
        guard let image = image else {
            print("エラーアラート:写真を追加してね！")
            return
        }
        upLoad(name: itemName, category: categoryName, image:image, success: {
            completionHandler()
        },
            failure: {
            print("アラート表示")
        })
    }
}
