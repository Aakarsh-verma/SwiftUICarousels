//
//  PeekCard.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 25/10/25.
//

import SwiftUI

struct PeekCard: View {
    let width: CGFloat = min(UIScreen.main.bounds.width * 0.75, 380)
    var cornerRadius: CGFloat = 20
    var data: PreviewDataModel?
    
    @State private var offset: CGFloat = 250
    @State private var dragOffset: CGFloat = 0
    
    init(_ content: CardPreviewContent) {
        self.data = content.getPreviewData()
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            getImageBackgroundView()
            
            if let description = data?.description {
                getDescriptionView(description)
            }
        }
        .frame(minWidth: width, maxWidth: width, maxHeight: 350, alignment: .center)
        .transition(.asymmetric(insertion: .scale(scale: 0.95).combined(with: .opacity), removal: .opacity))
        .zIndex(10)
    }
    
    fileprivate func getImageBackgroundView() -> some View {
        return RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(.ultraThinMaterial)
            .shadow(radius: 18, y: 8)
            .overlay { 
                if let image = data?.image {
                    CustomImageView(image)
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: width, maxWidth: width, maxHeight: 350, alignment: .center)
                        .clipShape(.rect(cornerRadius: cornerRadius))
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .strokeBorder(.white.opacity(0.10))
                }
            }
    }
    
    fileprivate func getDescriptionView(_ description: String) -> some View {
        return VStack { 
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text(description)
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .padding(.top)
                }
                .padding(.horizontal)
            }
        }
        .scrollDisabled(offset > 28)
        .padding(.top)
        .background(.ultraThickMaterial.opacity(0.5))
        .clipShape(.rect(cornerRadius: cornerRadius))
        .offset(y: offset + dragOffset)
        .clipShape(.rect(cornerRadius: cornerRadius))
        .getContentDragGesture(offset: $offset, 
                               dragOffset: $dragOffset,
                               pullDownOffset: 250,
                               min: 28, 
                               max: 250)
    }
    
    private func ContentDragGesture() -> some Gesture {
        return DragGesture()
            .onChanged { value in
                let total = offset + value.translation.height
                if total >= 28 && total < 250 {
                    dragOffset = value.translation.height
                }
            }
            .onEnded { value in
                let newOffset = offset + value.translation.height
                print("Offset", offset)
                print(newOffset)
                withAnimation(.spring()) {
                    offset = max(0, min(250, newOffset))
                    dragOffset = 0
                }
            }
    }
}

#Preview {
    PeekCard(CardModel.init())
}
