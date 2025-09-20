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
            CustomImageView(imageModel: content.image)
                .aspectRatio(contentMode: .fill)
                .clipShape(.rect(cornerRadius: 20))
                .overlay {
                    gradientView
                }
            
            VStack {
                HStack {
                    Spacer()
                    favoriteIcon()
                }
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Spacer()
                VStack(alignment: .leading) {
                    textView()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.bottom, 32)
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
    
    @ViewBuilder
    private func favoriteIcon() -> some View {
        let iconModel = IconModel(
            name: "heart",
            type: .secondary,
            size: .Regular,
            color: .white,
            bgColor: .clear,
            tapAction: {
                content.isFavorite.toggle()
                isFavorite = content.isFavorite
            })
        IconView(with: iconModel, isFilled: $isFavorite)
            .padding(.top)
            .padding(.trailing, 24)
    }
    
    @ViewBuilder
    private func textView() -> some View {
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
}

#Preview {
    CoverCarouselCardView(path: .constant(.init()), content: .constant(.init()))
}
