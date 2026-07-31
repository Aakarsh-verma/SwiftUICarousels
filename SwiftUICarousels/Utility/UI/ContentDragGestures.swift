//
//  ContentDragGestures.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 26/10/25.
//

import SwiftUI

extension View {
    func getContentDragGesture(offset: Binding<CGFloat>,
                               dragOffset: Binding<CGFloat>,
                               topSpace: CGFloat = 0,
                               pullDownOffset: CGFloat,
                               min minOffset: CGFloat,
                               max maxOffset: CGFloat) -> some View {
        return self.gesture(
            DragGesture()
            .onChanged { value in
                let total = offset.wrappedValue + value.translation.height
                if total >= minOffset && total < maxOffset {
                    dragOffset.wrappedValue = value.translation.height
                }
            }
            .onEnded { value in
                let newOffset = offset.wrappedValue + value.translation.height
                withAnimation(.spring()) {
                    offset.wrappedValue = max(topSpace, min(pullDownOffset, newOffset))
                    dragOffset.wrappedValue = 0
                }
            }
        )
            
    }
}
