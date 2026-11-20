//
//  MenuItem.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 20/11/26.
//

import SwiftUI

struct MenuItem: View {
    let item: MenuItemModel

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: item.icon)
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.secondary)
                .frame(width: 48, height: 48)
                .clayCard(radius: 16)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 16, weight: .semibold))

                Text(item.subtitle)
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 6)

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.tertiary)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .contentShape(Rectangle())
    }
}

#Preview {
    let item = MenuItemModel(
        title: "Account",
        subtitle: "Profile, security and devices",
        icon: "person"
    )
    MenuItem(item: item)
}
