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
}

extension PostViewModel {
    func upLoad(name: String, category: String, image: UIImage) async throws {
        let imageData = image.jpegData(compressionQuality: 1.0)
        guard let imageData = imageData else {
            print("imageをData型に変換できない")
            return
        }
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
            headers: nil).responseString { response in
                guard let statusCode = response.response?.statusCode else {return}
                print(statusCode)
                do {
                    switch statusCode {
                    case 200 ..< 400:
                        print("成功")
                    case 400 ..< 500:
                        throw APIClientError.networkError
                        print("エラー")
                    case 500...:
                        throw APIClientError.networkError
                        print("サーバーエラー")
                    default:
                        print("error")
                    }
                } catch {

                }
            }
    }
}
