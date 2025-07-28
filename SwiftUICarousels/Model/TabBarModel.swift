//
//  TabBarModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 25/05/25.
//

import SwiftUI


struct TabBarModel {
    var items: [TabBarItem]
    
    init(items: [TabBarItem]) {
        self.items = items
    }
}

struct FloatingTabConfig {
    var activeTint: Color = .black
    var activeBackgroundTint: Color = .white
    var inactiveTint: Color = .white
    var tabAnimation: Animation = .smooth(duration: 0.35, extraBounce: 0)
    var backgroundColor: Color = .black
    var insetAmount: CGFloat = 6
    var isTranslucent: Bool = true
}


enum TabBarItem: String, CaseIterable, FloatingTabProtocol {
    case home = "Home"
    case search = "Search"
    case favorites = "Favorites"
    case profile = "Profile"
    
    var symbolImage: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .favorites:
            return "heart"
        case .profile:
            return "person"
        }
    }
}

protocol FloatingTabProtocol {
    var symbolImage: String { get }
}
