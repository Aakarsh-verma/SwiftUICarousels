//
//  StackCarouselWidget.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 24/05/25.
//

import SwiftUI

struct StackCarouselWidget: View {
    @State private var currentIndex = 0
    
    var body: some View {
        StackCarouselView(items: sampleImages, currentIndex: $currentIndex) { imageModel in
            CustomImageView(imageModel: CustomImageModel(for: imageModel.image))
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 20))
        }
        .frame(height: 300)
    }
}

#Preview {
    StackCarouselWidget()
}
