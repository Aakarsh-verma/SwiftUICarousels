//
//  StackCarouselView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 24/05/25.
//

import SwiftUI


struct StackCarouselView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    var items: Data
    @Binding var currentIndex: Int
    var content: (Data.Element) -> Content
    
    var body: some View {
        GeometryReader { proxy in
            let cardWidth: CGFloat = proxy.size.width * 0.65

            ZStack {
                ForEach(Array(items.enumerated()), id: \.1.id) { index, item in
                    
                    ItemView(item, for: index, with: cardWidth)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        scrollEffect(value)
                    }
            )
        }
    }
    
    @ViewBuilder
    private func ItemView(_ item: Data.Element, for index: Int, with cardWidth: CGFloat) -> some View {
        let offsetFromCurrent = index - currentIndex
        
        let scale = offsetFromCurrent == 0 ? 1.0 : abs(offsetFromCurrent) == 1 ? 0.85 : 0.75
        let xOffset = CGFloat(offsetFromCurrent) * 50
        let zIndex = Double(items.count - abs(offsetFromCurrent))
        
        content(item)
            .frame(width: cardWidth)
            .scaleEffect(scale)
            .offset(x: xOffset)
            .zIndex(zIndex)
            .opacity(abs(offsetFromCurrent) <= 1 ? 1 : 0)
            .transition(.opacity)
            .animation(.linear, value: currentIndex)
            .onTapGesture {
                if index > currentIndex {
                    currentIndex += 1
                } else if index < currentIndex {
                    currentIndex -= 1
                }
            }
    }
    
    private func scrollEffect(_ value: DragGesture.Value) {
        let threshold: CGFloat = 50
        if value.translation.width < -threshold && currentIndex < items.count - 1 {
            currentIndex += 1
        } else if value.translation.width > threshold && currentIndex > 0 {
            currentIndex -= 1
        }
    }
}

#Preview {
    @Previewable @State var currentIndex = 0

    StackCarouselView(items: sampleImages, currentIndex: $currentIndex) { imageModel in
        CustomImageView(imageModel: CustomImageModel(for: imageModel.image))
            .scaledToFit()
            .clipShape(.rect(cornerRadius: 20))
    }
}
