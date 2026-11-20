//
//  ClayMorph.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 20/11/26.
//

import SwiftUI

// MARK: - Theme

enum ClayTheme {
    static let accent = Color(
        red: 1.0, green: 0.65, blue: 0.56
    )

    static func background(_ dark: Bool) -> Color {
        dark
            ? Color(red: 0.10, green: 0.10, blue: 0.14)
            : Color(red: 0.97, green: 0.94, blue: 0.93)
    }

    static func surface(_ dark: Bool) -> Color {
        dark
            ? Color(red: 0.17, green: 0.17, blue: 0.22)
            : Color(red: 0.99, green: 0.96, blue: 0.95)
    }

    static func shadow(_ dark: Bool) -> Color {
        dark ? .black.opacity(0.4) : .brown.opacity(0.13)
    }
}

// MARK: - Clay Card Modifier

struct ClayCardModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    let cornerRadius: CGFloat

    private var dark: Bool {
        colorScheme == .dark
    }

    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(
                    cornerRadius: cornerRadius,
                    style: .continuous
                )
                .fill(ClayTheme.surface(dark).gradient)
                .shadow(
                    color: ClayTheme.shadow(dark),
                    radius: 16,
                    x: 7,
                    y: 10
                )
                .shadow(
                    color: dark
                        ? .white.opacity(0.06)
                        : .white.opacity(0.9),
                    radius: 8,
                    x: -5,
                    y: -5
                )
                .overlay {
                    RoundedRectangle(
                        cornerRadius: cornerRadius,
                        style: .continuous
                    )
                    .strokeBorder(
                        .white.opacity(dark ? 0.12 : 0.85),
                        lineWidth: 1
                    )
                }
            }
    }
}

extension View {
    func clayCard(radius: CGFloat = 28) -> some View {
        modifier(ClayCardModifier(cornerRadius: radius))
    }
}
