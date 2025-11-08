//
//  CustomTabView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 25/05/25.
//

import SwiftUI

struct CustomTabView: View {
    @State var tabBarItems: [TabBarItem] = [.home, .search, .favorites, .profile]
    @State var activeTab: TabBarItem = .home
    @State private var hideTabBar: Bool = false
    @StateObject private var overlay = OverlayCoordinator()

    var body: some View {
        FloatingTabView(selection: $activeTab, tabItems: $tabBarItems, hideTabBar: $hideTabBar) { tabBarItem, tabHeight in
            switch tabBarItem {
            case .home:
                HomeView()
            case .search:
                SearchView(hideTabBar: $hideTabBar)
            case .favorites:
                FavoritesView()
            case .profile:
                ContentView()
            }
        }
        .environmentObject(overlay)
        .overlay {
            if overlay.isPresented, let content = overlay.content {
                content
            }
        }
        .animation(.bouncy, value: overlay.isPresented)
        .simultaneousGesture(
            TapGesture().onEnded {
                if overlay.isPresented {
                    overlay.isScreenTapped.toggle()
                }
            }
        )

    }
}

#Preview {
    CustomTabView()
}
