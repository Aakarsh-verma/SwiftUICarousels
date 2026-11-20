//
//  MenuModels.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 20/11/26.
//

import Foundation

// MARK: - Settings Menu Model

public enum MenuItemViewType: String {
    case profile
    case insights
    case defaultItem
}

public struct MenuItemModel: Identifiable, Hashable  {
    public let id = UUID()
    public let title: String
    public let subtitle: String
    public let icon: String
    public let type: MenuItemViewType
    
    public init(
        title: String,
        subtitle: String,
        icon: String,
        type: MenuItemViewType = .defaultItem
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.type = type
    }
}
