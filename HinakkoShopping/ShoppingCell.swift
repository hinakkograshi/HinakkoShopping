//
//  ShoppingCell.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/02.
//

import SwiftUI

struct ShoppingCell: View {
    var body: some View {
        VStack {
            Image("hinakkoIcon")
                .resizable()
                .scaledToFit()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding(20)
            VStack {
                Text("photo")
                    .font(.headline)
                Text("category")
                    .font(.subheadline.bold())
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.25))
                    }
            }
        }
        .padding(.bottom, 10)
        .background(.gray)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ShoppingCell()
}
