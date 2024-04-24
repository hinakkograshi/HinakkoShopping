//
//  PostViewModel.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/09.
//

import SwiftUI
import Alamofire

final class PostViewModel: ObservableObject {
    let baseURL = "http://127.0.0.1:9000/items"
    let headers: HTTPHeaders = [
        "Content-type": "multipart/form-data"
    ]
}
extension PostViewModel {
    func upLoad(name: String, category: String, image: UIImage, success: @escaping () -> Void, failure: @escaping () -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        let nameData = name.data(using: .utf8)!
        let categoryData = category.data(using: .utf8)!
        
        AF.upload(
            multipartFormData: {(multipartFormData) in
                // 文字データ
                multipartFormData.append(nameData, withName: "name")
                multipartFormData.append(categoryData, withName: "category")
                // 画像ファイル
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            },
            to: baseURL,
            method: .post,
            headers: headers).responseString { response in
                switch response.result {
                case .success(let result):
                    success()
                case .failure(let error):
                    print(error.localizedDescription)
                    failure()
                }
            }
    }
}
