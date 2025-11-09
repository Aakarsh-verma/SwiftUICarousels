//
//  CustomGridView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 12/07/25.
//

import SwiftUI

struct CustomGridView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    let items: Data
    let containerSize: CGFloat
    let itemSizeRatio: CGFloat
    let layout: [GridItem]
    let isVertical: Bool 
    var content: (Data.Element) -> Content
    var action: ((Data.Element) -> Void)?
    
    private var cardWidth: CGFloat {
        containerSize * itemSizeRatio
    }
    
    @Namespace private var peekNS
    @EnvironmentObject private var overlay: OverlayCoordinator
    @State private var peekItem: CardPreviewContent?
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
        gridContent
        .onChange(of: showPeek) { oldValue, newValue in
            if newValue, let peekItem {
                presentPeek(peekItem)
            }
        }
        .onChange(of: overlay.isScreenTapped, { oldValue, newValue in
            if newValue {
                dismissPeek()
            }
        })
    }
    
    @ViewBuilder
    private var gridContent: some View {
        if isVertical {
            LazyVGrid(columns: layout, spacing: 12) { 
                gridItems                
            }
        } else {
            ScrollView(.horizontal ,showsIndicators: false) {
                LazyHGrid(rows: layout, spacing: 12) { 
                    gridItems
                }
            }
        }
    }
    
    @ViewBuilder
    private var gridItems: some View {
        ForEach(items) { item in
            ItemView(item, with: cardWidth)
        }
    }
    
    @ViewBuilder
    private func ItemView(_ item: Data.Element, with cardWidth: CGFloat) -> some View {
        content(item)
            .frame(width: cardWidth)
            .matchedGeometryEffect(id: AnyHashable(item.id), in: peekNS, isSource: !showPeek)
            .radialTapGesture {
                action?(item)
            }
            .sensoryFeedback(.impact, trigger: peekItem != nil)
            .onLongPressGesture(minimumDuration: 0.25) { 
                withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.8, blendDuration: 0.5)) {
                    peekItem = getCardPreviewContent(item)
                    showPeek = true
                }
            }
    }
    
    private func getCardPreviewContent(_ item: Data.Element) -> CardPreviewContent? {
        if let cardModel = (item as? Binding<CardModel>)?.wrappedValue as? CardPreviewContent {
            return cardModel
        } else if let imageModel = (item as? Binding<ImageModel>)?.wrappedValue as? CardPreviewContent {
            return imageModel
        } else if let content = item as? CardPreviewContent {
            return content
        }
        return nil
    }
    
    private func isPeekTarget(_ item: Data.Element) -> Bool {
        guard let pid = peekItem?.id else { return false }
        return AnyHashable(pid) == AnyHashable(item.id)
    }
    
    private func presentPeek(_ content: CardPreviewContent) {
        overlay.show(
            PeekCard(content)
                .matchedGeometryEffect(id: AnyHashable(content.id), in: peekNS, isSource: showPeek)
                .transition(.scale.combined(with: .opacity))
                .animation(.bouncy, value: showPeek)
        )
    }
    
    private func dismissPeek() {
        withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.9)) {
            overlay.hide()
            showPeek = false
            peekItem = nil
        }
    }
    
}

#Preview {
    @Previewable @StateObject var overlay = OverlayCoordinator()
    ScrollView {
        CustomGridView(items: sampleImages) { imageModel in
            CustomImageView(CustomImageModel(for: imageModel.image))
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 20))
            
        } action: {_ in}
            .padding(.horizontal)
            .environmentObject(overlay)
            .overlay {
                if overlay.isPresented, let content = overlay.content {
                    content
                }
            }
            .animation(.bouncy, value: overlay.isPresented)
    }
}
