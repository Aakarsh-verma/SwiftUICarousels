//
//  Extenstions.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 12/07/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func applyIf<Content: View>(
        _ condition: Bool,
        modifier: (Self) -> Content
    ) -> some View {
        if condition {
            modifier(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func applyIfLet<Value, Content: View, ElseContent: View>(
        _ value: Value?,
        modifier: (Self, Value) -> Content,
        else elseModifier: (Self) -> ElseContent
    ) -> some View {
        if let value = value {
            modifier(self, value)
        } else {
            elseModifier(self)
        }
    }

    @ViewBuilder
    func applyIfLetAnd<Value, Content: View>(
        _ condition: Bool,
        value: Value?,
        modifier: (Self, Value) -> Content
    ) -> some View {
        if condition, let value = value {
            modifier(self, value)
        } else {
            self
        }
    }
    
    func onGlobalAppTouch(_ action: @escaping (_ phase: UITouch.Phase, _ location: CGPoint) -> Void) -> some View {
        self.background(GlobalTouchWindowObserver(onTouch: action))
    }
    
    @ViewBuilder
    func pinchZoom() -> some View {
        PinchZoomHelper { self }
    }
}

extension Identifiable {
    func getContentFromBinding<T>() -> T? {
        if let content = self as? Binding<T> { return content.wrappedValue }
        return nil
    }
}

