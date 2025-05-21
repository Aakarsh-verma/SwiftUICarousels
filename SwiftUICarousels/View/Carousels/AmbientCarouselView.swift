//
//  AmbientCarouselView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 17/05/25.
//

import SwiftUI

struct AmbientCarouselView: View {
    @Binding var topInset: CGFloat
    @Binding var scrollOffsetY: CGFloat
    @State var scrollProgresX: CGFloat = 0
    @Binding var images: [ImageModel]
    var body: some View {
        CarouselView()
    }
    
    @ViewBuilder
    func CarouselView() -> some View {
        let spacing: CGFloat = 10
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: spacing) {
                ForEach(images) { model in
                    CustomImageView(imageModel: CustomImageModel(for: model.image))
                        .aspectRatio(contentMode: .fill)
                        .containerRelativeFrame(.horizontal)
                        .frame(height: 380)
                        .clipShape(.rect(cornerRadius: 12))
                        .shadow(color: .black.opacity(0.4), radius: 5, x: 5, y: 5)
                }
            }
            .scrollTargetLayout()
        }
        .frame(height: 380)
        .background(BackDropCarouselView())
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
        .onScrollGeometryChange(for: CGFloat.self) {
            let offsetX = $0.contentOffset.x + $0.contentInsets.leading
            let width = $0.contentSize.width + spacing
            
            return offsetX / width
        } action: { oldValue, newValue in
            let maxValue = CGFloat(images.count - 1)
            scrollProgresX = min(max(newValue, 0), maxValue) * CGFloat(images.count)
        }

    }
    
    @ViewBuilder
    func BackDropCarouselView() -> some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                ForEach(images.reversed()) { model in
                    let index = CGFloat(images.firstIndex(where: { $0.id == model.id }) ?? 0) + 1
                    CustomImageView(imageModel: CustomImageModel(for: model.image))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .opacity(index - scrollProgresX)
                }
            }
            .compositingGroup()
            .blur(radius: 30, opaque: true)
            .overlay {
                Rectangle()
                    .fill(.black.opacity(0.35))
            }
            .mask {
                Rectangle()
                    .fill(.linearGradient(colors: [
                        .black,
                        .black,
                        .black,
                        .black,
                        .black.opacity(0.5),
                        .clear
                    ], startPoint: .top, endPoint: .bottom))
            }
        }
        .containerRelativeFrame(.horizontal)
        .padding(.bottom, -60)
        .padding(.top, -topInset)
        .offset(y: scrollOffsetY < 0 ? scrollOffsetY: 0)
    }
}

#Preview {
    AmbientCarouselView(topInset: .constant(100), scrollOffsetY: .constant(0), images: .constant(sampleImages))
        .preferredColorScheme(.dark)
}
