//
//  ExhibitView.swift
//  HinakkoShopping
//
//  Created by Hina on 2024/04/08.
//

import SwiftUI

struct ExhibitView: View {
    @State var showSheet = false
    
    var body: some View {
        Button(action: { showSheet = true}) {
            RoundedRectangle(cornerRadius: 100)
                .fill(.orange)
                .frame(width: 80, height: 80)
                .overlay {
                    Image(systemName: "camera")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundStyle(.white)
                }
        }
        .sheet(isPresented: $showSheet) {
            PostView()
        }
    }
}

#Preview {
    ExhibitView()
}
