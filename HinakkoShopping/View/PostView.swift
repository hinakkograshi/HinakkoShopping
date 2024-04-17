//
//  PostView.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/09.
//

import SwiftUI

struct PostView: View {
    let postVM = PostViewModel()
    @ObservedObject var viewModel = ShoppingViewModel()
    @State var showingImagePicker = false
    @State var image: UIImage?
    @State var itemName = ""
    @State var categoryName = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    showingImagePicker = true
                }) {
                    if let image = self.image {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 300, height: 300)
                    } else {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(.gray)
                            .frame(width: 300, height: 300)
                            .overlay {
                                Image(systemName: "camera")
                                    .font(.system(size: 100, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                    }
                }
                .padding(.vertical, 50)
                .sheet(isPresented: $showingImagePicker, content: {
                    ImagePicker(image: $image)
                })
                Grid(alignment: .leading, verticalSpacing: 30) {
                    GridRow {
                        Text("商品名")
                        TextField("商品名を入力", text: $itemName)
                            .textFieldStyle(.roundedBorder)
                    }
                    GridRow {
                        Text("カテゴリー")
                        TextField("カテゴリーを入力", text: $categoryName)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("出品する") {
                        guard let image = image else {
                            print("エラーアラート:写真を追加してね！")
                            return
                        }
                        Task {
                            do {
                                try await postVM.upLoad(name: itemName, category: categoryName, image: image)
                                dismiss()
                            } catch {
                                print("POSTError")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PostView()
}
