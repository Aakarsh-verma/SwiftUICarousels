//
//  PeekCard.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 25/10/25.
//

import SwiftUI

// MARK: - TO-DO PROPER IMPLEMENTATION NOT AN AI THROWN ONE

struct PeekCard<Content: View>: View {
    let width: CGFloat = min(UIScreen.main.bounds.width * 0.75, 380)
    var cornerRadius: CGFloat = 20
    @ViewBuilder var content: Content

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(.ultraThinMaterial)
            .shadow(radius: 18, y: 8)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(.white.opacity(0.10))
            )
            .overlay {
                content
                    .frame(minWidth: width, maxWidth: width, maxHeight: 350, alignment: .center)
            }
            .frame(minWidth: width, maxWidth: width, maxHeight: 350, alignment: .center)
            .transition(.asymmetric(insertion: .scale(scale: 0.95).combined(with: .opacity),
                                    removal: .opacity))
            .zIndex(10)
    }
}

#Preview {
    PeekCard {
        AnimeDetailView(content: .init())
    }
}
