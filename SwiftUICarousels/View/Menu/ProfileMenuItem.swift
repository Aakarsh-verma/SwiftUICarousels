//
//  ProfileMenuItem.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 20/11/26.
//

import SwiftUI

struct ProfileMenuItem: View {
    @Environment(\.colorScheme) private var colorScheme

    private var dark: Bool {
        colorScheme == .dark
    }
    var item: MenuItemModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: SCImages.placeholder.rawValue)
                .resizable()
                .scaledToFill()
                .frame(width: 72, height: 72)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.white.opacity(0.8), lineWidth: 3)
                }

            VStack(alignment: .leading, spacing: 5) {
                Text(item.title)
                    .font(.system(size: 21, weight: .bold))

                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 4)

            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 30)
                .fill(
                    LinearGradient(
                        colors: [
                            ClayTheme.surface(dark),
                            dark
                                ? Color.purple.opacity(0.18)
                                : ClayTheme.accent.opacity(0.25)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
        .clayCard(radius: 30)
    }
}

#Preview {
    let item = MenuItemModel(title: "Aakarsh Verma", subtitle: "iOS Developer", icon: "")
    ProfileMenuItem(item: item)
        .preferredColorScheme(.dark)
}
