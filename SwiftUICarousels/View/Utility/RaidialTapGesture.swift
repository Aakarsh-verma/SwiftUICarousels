//
//  RadialTapGesture.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 20/09/25.
//


import SwiftUI

struct RadialTapGestureModifier: ViewModifier {
    @State private var tapLocation: CGPoint?
    @State private var showGradient = false

    var action: () -> Void   // Closure to execute on tap

    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle())
            .onTapGesture { location in
                tapLocation = location
                showGradient = true
                
                withAnimation(.easeInOut(duration: 0.5)) { 
                    showGradient = false
                    self.action()
                }
            }
            .overlay(
                GeometryReader { geometry in
                    if let location = tapLocation, showGradient {
                        RadialGradient(
                            colors: [Color.white.opacity(0.2), Color.clear],
                            center: .init(x: location.x / geometry.size.width,
                                          y: location.y / geometry.size.height),
                            startRadius: 0,
                            endRadius: geometry.size.width * 0.7
                        )
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .brightness(0.2)
                        .blendMode(.plusLighter)
                        .transition(.opacity)
                        .animation(.easeOut(duration: 0.5), value: showGradient)
                    }
                }
            )
    }
}

extension View {
    func radialTapGesture(
        _ action: @escaping () -> Void = {}
    ) -> some View {
        self.modifier(RadialTapGestureModifier(action: action))
    }
}
