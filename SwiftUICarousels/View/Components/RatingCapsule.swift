//
//  RatingCapsule.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 01/06/25.
//

import SwiftUI

struct RatingConfig {
    let rating: String
    let color: Color 
    let borderColor: Color
    let showBorder: Bool
    
    init(color: Color = .white, 
         rating: String = "5.0", 
         showBorder: Bool = true,
         borderColor: Color = .gray) {
        self.color = color
        self.rating = rating
        self.showBorder = showBorder
        self.borderColor = borderColor
    }
}

struct RatingCapsule: View {
    let config: RatingConfig
    
    init(_ config: RatingConfig = RatingConfig()) {
        self.config = config
    }
        
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: "star.fill")
                .font(CTextStyle.subHeadline2.font)
            
            Text(config.rating)
                .font(CTextStyle.subHeadline.font)
        }
        .foregroundStyle(config.color)
        .padding(.vertical, 4)
        .padding(.horizontal, 6)
        .applyIf(config.showBorder, modifier: { view in
            view
                .overlay {
                    Capsule(style: .continuous)
                        .fill(.clear)
                        .stroke(config.borderColor.secondary, style: .init(lineWidth: 1))
                } 
        })
    }
}

#Preview {
    RatingCapsule()
        .preferredColorScheme(.dark)
}
