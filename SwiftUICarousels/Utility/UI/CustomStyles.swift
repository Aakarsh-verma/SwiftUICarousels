//
//  Untitled.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 17/05/25.
//

import SwiftUI

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

enum CTextStyle {    
    case caption(CGFloat)
    case title2
    case subHeadline
    case subHeadline2
    
    var font: Font {
        switch self {
        case .caption(let scale):
            Font.system(size: UIFont.preferredFont(forTextStyle: .caption1).pointSize * scale, weight: .bold)
        case .title2:
            Font.system(size: UIFont.preferredFont(forTextStyle: .title2).pointSize, weight: .bold)
        case .subHeadline:
            Font.system(size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
        case .subHeadline2:
            Font.system(size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize - 3)
        }
    }
}
