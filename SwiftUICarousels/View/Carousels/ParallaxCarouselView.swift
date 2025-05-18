//
//  ParallaxCarouselView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 18/05/25.
//

import SwiftUI

struct ParallaxCarouselView: View {
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(trips) { trip in
                        GeometryReader { proxy in
                            let cardSize = proxy.size
                            let minX = min(((proxy.frame(in: .scrollView).minX - 30) * 1.4), size.width * 1.4)
//                            let minX = proxy.frame(in: .scrollView).minX - 30

                            Image(trip.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .offset(x: -minX)
                                .frame(width: cardSize.width, height: cardSize.height)
                                .overlay {
                                    OverlayView(trip)
                                }
                                .clipShape(.rect(cornerRadius: 12))
                                .shadow(color: .black.opacity(0.25), radius: 8, x: 5, y: 10)
                        }
                        .frame(width: size.width - 60, height: size.height - 50)
                        .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                            view
                                .scaleEffect(phase.isIdentity ? 1 : 0.95)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .scrollTargetLayout()
                .frame(height: size.height, alignment: .top)
            }
            .scrollTargetBehavior(.viewAligned)
        }
        .frame(height: 500)
        .padding(.horizontal, -15)
        .padding(.top, 10)
    }
    
    @ViewBuilder
    func OverlayView(_ card: TripModel) -> some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(colors: [
                .clear,
                .clear,
                .clear,
                .clear,
                .clear,
                .black.opacity(0.1),
                .black.opacity(0.5),
                .black
            ], startPoint: .top, endPoint: .bottom)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(card.title)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                
                Text(card.subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(20)
        }
    }
}

#Preview {
    ParallaxCarousel()
}
