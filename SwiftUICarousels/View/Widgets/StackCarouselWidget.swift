//
//  StackCarouselWidget.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 24/05/25.
//

import SwiftUI

struct StackCarouselWidget: View {
    @State private var currentIndex = 0
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        StackCarouselView(items: viewModel.animeImages.isEmpty ? sampleImages : viewModel.animeImages, currentIndex: $currentIndex) { imageModel in
            CustomImageView(imageModel: CustomImageModel(for: imageModel.image))
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 20))
        }
        .frame(height: 240)
    }
}

#Preview {
    StackCarouselWidget()
        .environmentObject(HomeViewModel())
}
