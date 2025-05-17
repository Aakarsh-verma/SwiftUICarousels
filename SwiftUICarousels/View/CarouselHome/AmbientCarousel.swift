//
//  AmbientCarousel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 17/05/25.
//

import SwiftUI

struct AmbientCarousel: View {
    @State var topInset: CGFloat = 0
    @State var scrollOffsetY: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {
                HeaderView()
                
                AmbientCarouselView(topInset: $topInset, scrollOffsetY: $scrollOffsetY)
                    .zIndex(-1)
            }
        }
        .safeAreaPadding(15)
        .background(
            Rectangle()
                .fill(.black.gradient)
                .scaleEffect(-1)
                .ignoresSafeArea(.all)
        )
        .onScrollGeometryChange(for: ScrollGeometry.self, of: {
            $0
        }, action: { oldValue, newValue in
            topInset = max(newValue.contentInsets.top, 100) + 100
            scrollOffsetY = newValue.contentInsets.top + newValue.contentOffset.y
        })
        .navigationTitle("Ambient Carousel")
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AmbientCarousel()
}
