//
//  CoverCarouselCardView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 24/05/25.
//

import SwiftUI

struct CoverCarouselCardView: View {
    @State private var isFavorite: Bool = false
    @Binding var path: NavigationPath
    @Binding var content: CardModel
    
    var dimensions: CGSize = .init(width: 300, height: 400)
    private let fontScale: CGFloat = 1.2
    
    var body: some View {
        ZStack {
            CustomImageView(content.image)
                .aspectRatio(contentMode: .fill)
                .clipShape(.rect(cornerRadius: 20))
                .overlay {
                    gradientView
                }
            
            VStack(alignment: .trailing) {
                favoriteIcon
                    .padding(8)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            VStack(alignment: .leading) {
                Spacer()
                VStack(alignment: .leading) {
                    textView()
                }
                .padding([.leading, .bottom])
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(width: dimensions.width, height: dimensions.height)
        .radialTapGesture {
            path.append(content)
        }
    }
    
    var gradientView: some View {
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
    
    private var favoriteIcon: some View {
        let iconModel = IconModel(
            name: "heart",
            type: .secondary,
            size: .Small,
            color: .white,
            bgColor: .clear,
            tapAction: {
                content.isFavorite.toggle()
                isFavorite = content.isFavorite
            })
        return IconView(with: iconModel, isFilled: $isFavorite)
    }
    
    @ViewBuilder
    private func textView() -> some View {
        LazyVStack(alignment: .leading, spacing: 4) { 
            Text(content.season)
                .font(CTextStyle.caption(fontScale).font)
                .foregroundColor(.white.opacity(0.85))
            
            Text(content.title)
                .font(CTextStyle.title2.font)
                .lineLimit(2)
                .truncationMode(.tail)
                .multilineTextAlignment(.leading)
                .foregroundColor(.white)
            
            ratingAndReviews
        }
    }
    
    private var ratingAndReviews: some View {
        HStack(spacing: 4) {
            RatingCapsule(content.getRatingConfig())
            
            Text("\(content.review) reviews")
                .font(CTextStyle.subHeadline.font)
                .foregroundColor(.white.opacity(0.8))
        }
    }
}

#Preview {
    CoverCarouselCardView(path: .constant(.init()), content: .constant(.init()))
}
