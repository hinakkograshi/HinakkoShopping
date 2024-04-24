//
//  ShoppingCell.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/02.
//

import SwiftUI
import Kingfisher

struct ShoppingCell: View {
    let items: Items
    @ObservedObject var viewModel = ShoppingViewModel()
    var body: some View {
        VStack {
            KFImage(URL(string: viewModel.fetchItemImgString(id: items.id)))
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(10)
            VStack {
                HStack {
                    Text("name:")
                        .font(.headline)
                    Text(items.name)
                        .font(.headline)
                }
                HStack {
                    Text("category:")
                        .font(.subheadline.bold())
                    Text(items.category)
                        .font(.subheadline.bold())
                        .foregroundStyle(.black)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 8)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white.opacity(0.7))
                        }
                }
            }
        }
        .padding(.vertical, 10)
        .background(.yellow.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
