//
//  GridCard.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 12/07/25.
//

import SwiftUI

struct GridCard: View {
    @State private var isFavorite: Bool = false
    @Binding var path: NavigationPath
    @Binding var content: CardModel
    
    private let fontScale: CGFloat = 1.2
    
    var body: some View {
        ZStack {
            CustomImageView(imageModel: content.image)
                .aspectRatio(contentMode: .fit)
                .clipShape(.rect(cornerRadius: 20))
                .overlay {
                    gradientView
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
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
        }
        .radialTapGesture {
            path.append(content)
        }
        .task {
            self.isFavorite = content.isFavorite
        }
        .clipped()
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
        }
        .clipShape(.rect(cornerRadius: 20))
    }
    
    @ViewBuilder
    private func favoriteIcon() -> some View {
        let iconModel = IconModel(
            name: "heart",
            type: .tertiary,
            size: .Regular,
            color: .white,
            bgColor: .clear,
            tapAction: {
                content.isFavorite.toggle()
                isFavorite = content.isFavorite
                Task(priority: .background) { 
                    await favoritesToggle()
                }
            })
        IconView(with: iconModel, isFilled: $isFavorite)
            .padding(.top)
            .padding(.trailing)
    }
    
    @ViewBuilder
    private func textView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(content.title)
                .font(.system(size: UIFont.preferredFont(forTextStyle: .title2).pointSize, weight: .bold))
                .lineLimit(2)
                .truncationMode(.tail)
                .multilineTextAlignment(.leading)
                .foregroundColor(.white)
            
            RatingCapsule(rating: content.rating, showBorder: false)
                .padding(.leading, -8)
        }
        
    }
    
    private func favoritesToggle() async {
        if isFavorite {
            await AppViewModel.shared.addCard(content)
        } else {
            await AppViewModel.shared.removeCard(content)
        }
    }
}

#Preview {
    GridCard(path: .constant(.init()), content: .constant(.init()))
        .frame(width: UIScreen.main.bounds.width / 2)
}
