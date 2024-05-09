//
//  APIClient.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/30.
//

import Foundation
import Alamofire
import UIKit

struct APIClient {
    //ItemDTOデコード -> Item

    static func fetchAllItems() async throws -> [Item] {
        guard let url = URL.forAllItems() else {
            throw NetworkError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpStatus = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }
        switch httpStatus.statusCode {
        case 100 ... 199:
            throw HTTPClientError.informational
        case 200 ... 299:
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let responseData = try? jsonDecoder.decode(Items.self, from: data) else {
                throw NetworkError.decodeFailed
            }
            let itemsData = responseData.items
            print(itemsData)
            return itemsData
        case 300 ... 399:
            throw HTTPClientError.redirection
        case 400 ... 499:
            throw HTTPClientError.clientError
        case 500 ... 599:
            throw HTTPClientError.serverError
        default:
            throw HTTPClientError.invalid
        }
    }

    static func fetchItemImgString(id: Int) throws -> URL {
        guard let itemURL = URL.forItemImg(id: id) else {
            throw NetworkError.invalidURL
        }
        return itemURL
    }

    func upLoad(name: String, category: String, image: UIImage, success: @escaping () -> Void, failure: @escaping () -> Void) {
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        let nameData = name.data(using: .utf8)!
        let categoryData = category.data(using: .utf8)!
        guard let postURL = URL.forAllItems() else {
            return failure()
        }

        AF.upload(
            multipartFormData: {(multipartFormData) in
                // 文字データ
                multipartFormData.append(nameData, withName: "name")
                multipartFormData.append(categoryData, withName: "category")
                // 画像ファイル
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            },
            to: postURL,
            method: .post,
            headers: headers).responseString { response in
                switch response.result {
                case .success:
                    success()
                case .failure(let error):
                    print(error.localizedDescription)
                    failure()
                }
            }
    }
}
