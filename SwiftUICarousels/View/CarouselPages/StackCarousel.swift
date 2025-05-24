//
//  StackCarousel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 24/05/25.
//

import SwiftUI

struct StackCarousel: View {
    @State private var currentIndex = 0
    @StateObject var viewModel = HomeViewModel(contentType: .season((year: "2024", season: .winter)))
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                TopHeaderView()
                    .padding(.top)
                
                StackCarouselView(items: viewModel.animeImages, currentIndex: $currentIndex) { imageModel in
                    CustomImageView(imageModel: CustomImageModel(for: imageModel.image))
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 20))
                }
                .frame(height: 500)
            }
        }
        .navigationTitle("Stack Carousel")
        .task {
            await viewModel.fetchAnimeContent()
        }
    }
}

#Preview {
    StackCarousel()
        .preferredColorScheme(.dark)
}
