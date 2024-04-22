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
    func upLoad(name: String, category: String, image: UIImage) throws {
        let imageData = image.jpegData(compressionQuality: 1.0)
        guard let imageData = imageData else {
            throw ImageError.invalid
        }
        let nameData = name.data(using: .utf8)!
        let categoryData = category.data(using: .utf8)!
        //upLoad complitionHandler responseString内
        //withCheckedThrowingContinuation
        //comp受け取るメソッドを作る
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
                    case 100 ... 199:
                        throw APIClientError.informational
                    case 200 ..< 299:
                        break
                        //                        throw APIClientError.successful
                    case 300 ..< 399:
                        throw APIClientError.redirection
                    case 400 ..< 499:
                        throw APIClientError.clientError
                    case 500 ..< 599:
                        throw APIClientError.serverError
                    default:
                        throw APIClientError.invalid
                    }
                } catch {
                    print("\(statusCode)エラー")
                }
            }
        print("スコープ抜けます")
    }
}
