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
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding(20)
            VStack {
                Text(items.name)
                    .font(.headline)
                Text(items.category)
                    .font(.subheadline.bold())
                    .foregroundStyle(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.5))
                    }
            }
        }
        .padding(.bottom, 10)
        .background(.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
