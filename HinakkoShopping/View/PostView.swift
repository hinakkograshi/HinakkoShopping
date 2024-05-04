//
//  PostView.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/09.
//

import SwiftUI

struct PostView: View {
    @StateObject var postVM = PostViewModel()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    postVM.showingImagePicker = true
                }) {
                    if let image = postVM.image {
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
                .sheet(isPresented: $postVM.showingImagePicker, content: {
                    ImagePicker(image: $postVM.image)
                })
                Grid(alignment: .leading, verticalSpacing: 30) {
                    GridRow {
                        Text("商品名")
                        TextField("商品名を入力", text: $postVM.itemName)
                            .textFieldStyle(.roundedBorder)
                    }
                    GridRow {
                        Text("カテゴリー")
                        TextField("カテゴリーを入力", text: $postVM.categoryName)
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
                        postVM.didTappedPostButtan {
                            dismiss()
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
