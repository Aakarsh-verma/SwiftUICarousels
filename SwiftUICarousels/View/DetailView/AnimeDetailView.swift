//
//  AnimeDetailView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 01/06/25.
//

import SwiftUI

struct AnimeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var fullDescription: Bool = false
    var content: CardModel

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
                
                ContentView()
            }
            Spacer()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.dark)
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
    
    @ViewBuilder
    private func ContentView() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(content.title)
                        .font(.title.bold())
                    
                    Spacer()
                    
                    RatingCapsule(rating: content.rating, borderColor: .gray)
                }
                .padding(.horizontal)
                
                HStack(alignment: .top) {
                    Text(content.season)
                        .font(.system(size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize))
                    
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
                        .lineLimit(fullDescription ? nil : 2)
                        .truncationMode(.tail)
                        .foregroundStyle(.gray)
                    
                    Text(fullDescription ? "Read less" : "Read more")
                        .font(.subheadline)
                        .underline()
                        .padding(.top, 2)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                fullDescription.toggle()
                            }
                        }
                }
                .padding(.horizontal)
                .padding(.top)
                
                Spacer()
            }
            
            Rectangle()
                .fill(.clear)
                .frame(height: 72)
        }
        .padding(.top)
        .background(.black)
        .clipShape(.rect(cornerRadius: 24))
        .padding(.top, 200)
    }
}

#Preview {
    AnimeDetailView(content: .init())
}
