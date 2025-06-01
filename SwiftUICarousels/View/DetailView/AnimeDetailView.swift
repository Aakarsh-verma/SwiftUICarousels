//
//  AnimeDetailView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 01/06/25.
//

import SwiftUI

struct AnimeDetailView: View {
    var content: CardModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                CustomImageView(imageModel: content.image)
                    .aspectRatio(contentMode: .fit)
                    .ignoresSafeArea()
                
                HStack {
                    CircleButtonView(for: "chevron.left", backButton: true)
                    Spacer()
                    CircleButtonView(for: content.isWishlisted ? "heart.fill" : "heart")
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text(content.title)
                            .font(.title.bold())
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        RatingCapsule(rating: content.rating, color: .black, borderColor: .gray)
                    }
                    .padding(.horizontal)
                    
                    HStack(alignment: .top) {
                        Text(content.season)
                            .font(.system(size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize))
                            .foregroundStyle(.black)

                        Spacer()
                        
                        Text("\(content.review) reviews")
                            .font(.system(size: UIFont.preferredFont(forTextStyle: .caption1).pointSize * 1.3))
                            .foregroundStyle(.gray)
                            .underline()
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text(content.description)
                            .font(.subheadline)
                            .foregroundStyle(.gray)

                        Text("Read more")
                            .font(.subheadline)
                            .underline()
                            .foregroundStyle(.black)
                            .padding(.top, 2)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Spacer()
                }
                .padding(.top)
                .background(.white)
                .clipShape(.rect(cornerRadius: 20))
                .offset(y: 200)
            }
            Spacer()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    private func CircleButtonView(for image: String, backButton: Bool = false) -> some View {
        Button {
            if backButton { dismiss() }
        } label: {
            Circle()
                .fill(.white.secondary)
                .frame(width: 48, height: 48)
                .overlay(
                    Image(systemName: image)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.black)
                )
        }

    }
}

#Preview {
    AnimeDetailView(content: .init())
}
