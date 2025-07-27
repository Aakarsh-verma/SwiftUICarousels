//
//  CustomTabView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 25/05/25.
//

import SwiftUI

struct CustomTabView: View {
    @State var tabBarItems: [TabBarItem] = [.home, .search, .wishlist, .profile]
    @State var activeTab: TabBarItem = .home
    @State private var hideTabBar: Bool = false
    
    var body: some View {
        FloatingTabView(selection: $activeTab, tabItems: $tabBarItems, hideTabBar: $hideTabBar) { tabBarItem, tabHeight in
            switch tabBarItem {
            case .home:
                HomeView()
            case .search:
                SearchView(hideTabBar: $hideTabBar)
            case .wishlist:
                ContentView()
            case .profile:
                ContentView()
            }
        }
    }
}

#Preview {
    CustomTabView()
}
