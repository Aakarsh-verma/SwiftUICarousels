//
//  StackCarouselWidget.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 24/05/25.
//

import SwiftUI

struct StackCarouselWidget<T: Identifiable, Content: View>: View {
    @State private var currentIndex = 0
    
    var items: Binding<[T]>
    var height: CGFloat = CGFloat(240)
    var content: (Binding<T>) -> Content
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
    StackCarouselWidget(items: .constant(sampleImages)) { imageModel in
        CustomImageView(CustomImageModel(for: imageModel.image.wrappedValue))
            .scaledToFit()
            .clipShape(.rect(cornerRadius: 20))
    }
}

