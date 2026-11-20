//
//  MenuSectionItem.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 20/11/26.
//

import SwiftUI

struct MenuItemMangerView: View {
    var item: MenuItemModel
    
    var body: some View {
        switch item.type {
        case .profile:
            ProfileMenuItem(item: item)
        case .insights:
            InsightsMenuItem()
        case .defaultItem:
            MenuItem(item: item)
        }
    }
}

struct MenuSectionItem: View {
    var items: [MenuItemModel]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                MenuItemMangerView(item: item)
                
                if index < items.count - 1 {
                    Rectangle()
                        .fill(.primary.opacity(0.07))
                        .frame(height: 1)
                        .padding(.horizontal, 20)
                }
            }
        }
        .clayCard()
    }
}

#Preview {
    let groups = settingsGroups

    ScrollView {
        VStack(alignment: .leading, spacing: 12) {
            // Iterate groups safely using indices to avoid Hashable/Identifiable constraints on MenuItemModel
            ForEach(groups.indices, id: \.self) { groupIndex in
                // Pass each section of items to MenuSectionItem
                MenuSectionItem(items: groups[groupIndex])
            }

            // If you don't have sample data yet, render a couple of empty sections to visualize layout
            if groups.isEmpty {
                MenuSectionItem(items: [])
                MenuSectionItem(items: [])
            }
        }
        .padding()
    }
    
}
