//
//  CoverCarouselCardView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 24/05/25.
//

import SwiftUI

struct CoverCarouselCardView: View {
    var content: CardModel = .init()
    var dimensions: CGSize = .init(width: 300, height: 400)
    private let fontScale: CGFloat = 1.2
    @State private var wishlisted: Bool = false

    var body: some View {
        ZStack {
            CustomImageView(imageModel: content.image)
                .aspectRatio(contentMode: .fill)
                .clipShape(.rect(cornerRadius: 20))
                .overlay {
                    VStack {
                        Spacer()
                        
                        Rectangle()
                            .fill(LinearGradient(colors: [
                                .clear,
                                .black.opacity(0.3),
                                .black.opacity(0.4),
                                .black.opacity(0.4),
                                .black.opacity(0.5),
                                .black.opacity(0.6),
                                .black.opacity(0.8),
                                .black
                            ], startPoint: .top, endPoint: .bottom))
                            .frame(height: 0.5 * dimensions.height)
                    }
                    .clipShape(.rect(cornerRadius: 20))
                }
            
            VStack {
                HStack {
                    Spacer()
                    Circle()
                        .fill(.clear)
                        .stroke(.white.secondary, style: .init(lineWidth: 2))
                        .frame(width: 48, height: 48)
                        .overlay(
                            Image(systemName: wishlisted ? "heart.fill" : "heart")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(.white)
                        )
                        .padding(.top)
                        .padding(.trailing, 24)
                        .onTapGesture {
                            wishlisted.toggle()
                        }
                        .symbolEffect(.bounce.byLayer.down, value: wishlisted)
                }
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Spacer()
                VStack(alignment: .leading) {
                    Text(content.season)
                        .font(.system(size: UIFont.preferredFont(forTextStyle: .caption1).pointSize * fontScale, weight: .bold))
                        .foregroundColor(.white.opacity(0.85))
                    
                    Text(content.title)
                        .font(.system(size: UIFont.preferredFont(forTextStyle: .title2).pointSize, weight: .bold))
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 5) {
                        RatingCapsule(rating: content.rating)
                        
                        Text("  \(content.review) reviews")
                            .font(.system(size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.top, -12)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.bottom, 32)
            }
        }
        .frame(width: dimensions.width, height: dimensions.height)
    }
}

#Preview {
    CoverCarouselCardView()
}
