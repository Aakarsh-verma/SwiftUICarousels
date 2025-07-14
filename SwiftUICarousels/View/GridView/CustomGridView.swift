//
//  CustomGridView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 12/07/25.
//

import SwiftUI

struct CustomGridView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    let items: Data
    let itemSizeRatio: Double
    let layout: [GridItem]
    let isVertical: Bool 
    var content: (Data.Element) -> Content
    var action: (Data.Element) -> Void
    
    init(items: Data,
         numberOfLayout: Int = 2,
         itemSizeRatio: Double = 0.475,
         isVertical: Bool = true,
         content: @escaping (Data.Element) -> Content, 
         action: @escaping (Data.Element) -> Void) {
        self.items = items
        self.itemSizeRatio = itemSizeRatio
        self.layout = Array(repeating: GridItem(.flexible()), count: numberOfLayout)
        self.isVertical = isVertical
        self.content = content
        self.action = action
    }
    
    var body: some View {
        GeometryReader { proxy in
            let cardWidth: CGFloat = CGFloat(proxy.size.width * itemSizeRatio)
            
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
    }
    
    @ViewBuilder 
    func GridLayout(cardWidth: CGFloat) -> some View {
        ForEach(Array(items.enumerated()), id: \.1.id) { index, item in
            ItemView(item, for: index, with: cardWidth)
        }
    }
    
    @ViewBuilder
    private func ItemView(_ item: Data.Element, for index: Int, with cardWidth: CGFloat) -> some View {
        content(item)
            .frame(width: cardWidth)            
            .onTapGesture {
                action(item)
            }
    }
}

#Preview {
    ScrollView {
        CustomGridView(items: sampleImages) { imageModel in
            CustomImageView(imageModel: CustomImageModel(for: imageModel.image))
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 20))
            
        } action: {_ in}
            .padding(.horizontal)
    }
}
