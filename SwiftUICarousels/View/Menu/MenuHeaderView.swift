//
//  MenuHeaderView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 20/11/26.
//

import SwiftUI 

struct MenuHeaderView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 21))
                    .foregroundStyle(.secondary)
                    .frame(width: 48, height: 48)
                    .clayCard(radius: 17)
            }
            .buttonStyle(.plain)
            
            Text("Menu")
                .font(.system(size: 40, weight: .bold))
                .padding(.leading)
        }
        .padding(.bottom, 8)
    }
}

#Preview {
    MenuHeaderView()
}
