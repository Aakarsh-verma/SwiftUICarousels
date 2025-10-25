//
//  CustomGridView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 12/07/25.
//

import SwiftUI

// MARK: - TO-DO OPTIMIZE IMPLEMENTATION
// Bugs: 
// 1. Peek Co-ordinates
// 2. Peek Transition is too jumpy
// 3. Use Better way to transit peeker content
struct CustomGridView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    let items: Data
    let containerSize: CGFloat
    let itemSizeRatio: CGFloat
    let layout: [GridItem]
    let isVertical: Bool 
    var content: (Data.Element) -> Content
    var action: ((Data.Element) -> Void)?
    @Namespace private var peekNS
    @State private var peekItem: CardContentPreviewProtocol?
    @State private var peekFrame: CGRect = .zero // capture tapped item's position
    @State private var showPeek = false
    
    init(items: Data,
         numberOfLayout: Int = 2,
         itemSizeRatio: CGFloat = 0.45,
         isVertical: Bool = true,
         containerSize: CGFloat? = nil,
         content: @escaping (Data.Element) -> Content, 
         action: ((Data.Element) -> Void)? = nil) {
        self.items = items
        self.itemSizeRatio = itemSizeRatio
        self.layout = Array(repeating: GridItem(.flexible()), count: numberOfLayout)
        self.isVertical = isVertical
        self.content = content
        self.action = action
        self.containerSize = containerSize ?? UIScreen.main.bounds.width
    }
    
    var body: some View {
        VStack {
            let cardWidth: CGFloat = containerSize * itemSizeRatio
            
            if isVertical {
                LazyVGrid(columns: layout, spacing: 12) { 
                    GridLayout(cardWidth: cardWidth)                
                }
            } else {
                ScrollView(.horizontal ,showsIndicators: false) {
                    LazyHGrid(rows: layout, spacing: 12) { 
                        GridLayout(cardWidth: cardWidth)
                    }
                }
            }
        }
        .overlay { 
            if let peekItem, showPeek {
                ZStack(alignment: .topLeading) {
                    // Slight dim behind only visible content area
                    Color.black.opacity(0.001)
                        .contentShape(Rectangle())
                        .onGlobalAppTouch { _, _ in 
                            withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.9)) {
                                showPeek = false
                                self.peekItem = nil
                            }
                        }
                    
                    // Peek card anchored to the original frame
                    PeekCard {
                        AnimeDetailView(isBeingPeeked: true, content: peekItem.getCardContent())
                            .matchedGeometryEffect(id: peekItem.id, in: peekNS)
                    }
                    .frame(width: peekFrame.width, height: peekFrame.height)
                    .offset(x: peekFrame.minX, y: peekFrame.minY)
                    .transition(.scale.combined(with: .opacity))
                    .onAppear {
                        // Animate to expanded position
                        withAnimation(.interactiveSpring(response: 0.45, dampingFraction: 0.85)) {
                            peekFrame = CGRect(x: 20,
                                               y: 150,
                                               width: 280,
                                               height: 300)
                        }
                    }
                }
                .ignoresSafeArea()
            }
        }
    }
    
    @ViewBuilder 
    func GridLayout(cardWidth: CGFloat) -> some View {
        ForEach(Array(items.enumerated()), id: \.1.id) { index, item in
            ItemView(item, for: index, with: cardWidth)
        }
    }
    
    @ViewBuilder
    private func ItemView(_ item: Data.Element, for index: Int, with cardWidth: CGFloat) -> some View {
        var frame = CGRect.zero
        content(item)
            .frame(width: cardWidth)   
            .matchedGeometryEffect(id: item.id, in: peekNS)
            .radialTapGesture {
                action?(item)
            }
            .background(
                GeometryReader { geo in
                    let geoFrame = geo.frame(in: .global)
                    Color.clear
                        .task {
                            frame = geoFrame
                        }
                }
            )
            .sensoryFeedback(.impact, trigger: peekItem != nil)
            .onLongPressGesture(minimumDuration: 0.25) { 
                withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.8, blendDuration: 0.5)) {
                    let card: CardModel? = item.getContentFromBinding()
                    peekItem = card ?? nil
                    peekFrame = frame
                    showPeek = true
                }
            }
    }
}

#Preview {
    ScrollView {
        CustomGridView(items: sampleImages) { imageModel in
            CustomImageView(CustomImageModel(for: imageModel.image))
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 20))
            
        } action: {_ in}
            .padding(.horizontal)
    }
}
