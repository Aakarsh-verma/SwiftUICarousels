//
//  Untitled.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 17/05/25.
//

import SwiftUI

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
