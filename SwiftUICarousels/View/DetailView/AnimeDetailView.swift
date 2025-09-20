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
    @State private var offset: CGFloat = 200
    @State private var dragOffset: CGFloat = 0
    var content: CardModel

    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                AnimeImageView()
                    .ignoresSafeArea()
                
                if (offset + dragOffset) <= 48 {
                        Rectangle()
                            .fill(.black)
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                            .ignoresSafeArea()
                }
                
                HStack {
                    CircleButtonView(for: "chevron.left", backButton: true)
                    
                    Spacer()
                    if (offset + dragOffset) <= 48 {
                        Text(content.title)
                            .font(.title2)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    
                    Spacer()
                    
                    CircleButtonView(for: content.isFavorite ? "heart.fill" : "heart")
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
        let condition = (offset + dragOffset) <= 48
        Button {
            if backButton { dismiss() }
        } label: {
            Circle()
                .fill(condition ? .clear : .secondary)
                .frame(width: 48, height: 48)
                .overlay(
                    Image(systemName: image)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(condition ? .white : .black)
                )
        }

    }
    
    @ViewBuilder
    private func ContentView() -> some View {
        let totalOffset = offset + dragOffset
        let normalized = max(0, min(1, (totalOffset - 48) / (200 - 48)))
        let cornerRadius = normalized * 24
        
        VStack {
            Capsule()
                .fill(.gray.secondary)
                .frame(width: 80, height: 6)
                .padding(.bottom, 6)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        if (offset + dragOffset) <= 48 {
                            withAnimation(.easeInOut) {
                                AnimeImageView()
                                    .frame(width: 80)
                                    .clipShape(.rect(cornerRadius: 12))
                                    .padding(.trailing, 8)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            if (offset + dragOffset) > 48 {
                                withAnimation(.easeInOut) {
                                    Text(content.title)
                                        .font(.title.bold())
                                }
                            }
                            
                            Text(content.season)
                                .font(.system(size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize))
                            
                            if (offset + dragOffset) <= 48 {
                                HStack(spacing: 12) {
                                    Text("\(content.episodes) episodes")
                                        .font(.system(size: UIFont.preferredFont(forTextStyle: .caption1).pointSize * 1.3))
                                    
                                    Text("\(content.status)")
                                        .font(.system(size: UIFont.preferredFont(forTextStyle: .caption1).pointSize * 1.3))
                                        .underline()
                                        .foregroundStyle(.gray)
                                }
                                
                                RatingAndReviewView(vertical: false)
                                .padding(.top, 10)
                            }
                        }
                        
                        Spacer()
                        if (offset + dragOffset) > 48 {
                            RatingAndReviewView(vertical: true)
                        }
                    }
                    
                    ContentDescription()
                }
                .padding(.horizontal)
                
                Rectangle()
                    .fill(.clear)
                    .frame(height: 72)
            }
        }
        .scrollDisabled(offset > 48)
        .padding(.top)
        .background(.black)
        .clipShape(.rect(cornerRadius: cornerRadius))
        .offset(y: offset + dragOffset)
        .gesture(ContentDragGesture())
    }
    
    @ViewBuilder
    private func AnimeImageView() -> some View {
        CustomImageView(imageModel: content.image)
            .aspectRatio(contentMode: .fit)
    }
    
    var ratingView: some View {
        RatingCapsule(rating: content.rating, borderColor: .gray)
    }
    
    var reviewView: some View {
        Text("\(content.review) reviews")
            .font(.system(size: UIFont.preferredFont(forTextStyle: .caption1).pointSize * 1.3))
            .foregroundStyle(.gray)
            .underline()
    }
    
    @ViewBuilder
    private func RatingAndReviewView(vertical: Bool) -> some View {
        if vertical {
            VStack(alignment: .trailing, spacing: 8) {
                ratingView
                reviewView
            }
        } else {
            HStack(alignment: .center) {
                ratingView
                reviewView
            }
        }
    }
    
    @ViewBuilder
    private func ContentDescription() -> some View {
        Text(content.description)
            .font(.subheadline)
            .lineLimit(fullDescription ? nil : 2)
            .truncationMode(.tail)
            .foregroundStyle(.gray)
            .padding(.top)
        
        Text(fullDescription ? "Read less" : "Read more")
            .font(.subheadline)
            .underline()
            .padding(.top, 2)
            .radialTapGesture {
                withAnimation(.easeInOut) {
                    fullDescription.toggle()
                }
            }
    }
    
    private func ContentDragGesture() -> some Gesture {
        return DragGesture()
            .onChanged { value in
                let total = offset + value.translation.height
                if total >= 48 && total < 350 {
                    dragOffset = value.translation.height
                }
            }
            .onEnded { value in
                let newOffset = offset + value.translation.height
                withAnimation(.spring()) {
                    offset = max(48, min(200, newOffset))
                    dragOffset = 0
                }
            }
    }
}

#Preview {
    AnimeDetailView(content: .init())
}
