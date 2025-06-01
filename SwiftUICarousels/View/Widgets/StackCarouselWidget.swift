//
//  StackCarouselWidget.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 24/05/25.
//

import SwiftUI

struct StackCarouselWidget<T: Identifiable, Content: View>: View {
    @State private var currentIndex = 0
    
    var items: [T]
    var height: CGFloat = CGFloat(240)
    var content: (T) -> Content
    var perform: (() async -> Void)? = nil
    
    var body: some View {
        StackCarouselView(items: items, currentIndex: $currentIndex) { item in
            content(item)
        } action: { _ in
        }
        .frame(height: height)
        .task {
            if items.isEmpty {
                await perform?()
            }
        }
    }
}

#Preview {
    StackCarouselWidget(items: sampleImages) { imageModel in
        CustomImageView(imageModel: CustomImageModel(for: imageModel.image))
            .scaledToFit()
            .clipShape(.rect(cornerRadius: 20))
    }
}

