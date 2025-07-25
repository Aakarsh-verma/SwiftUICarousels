//
//  RatingCapsule.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 01/06/25.
//

import SwiftUI

struct RatingCapsule: View {
    var rating: String = "5"
    var color: Color = .white
    var borderColor: Color = .white
    var showBorder: Bool = true
    
    var body: some View {
        HStack(spacing: 12) {
            Label(rating, systemImage: "star.fill")
                .font(.system(size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize))
                .foregroundStyle(color)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
        }
        .applyIf(showBorder, modifier: { view in
            view
                .overlay {
                    Capsule(style: .continuous)
                        .fill(.clear)
                        .stroke(borderColor.secondary, style: .init(lineWidth: 2))
                } 
        })
    }
}

#Preview {
    RatingCapsule()
        .preferredColorScheme(.dark)
}
