//
//  FloatingTabView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 25/05/25.
//

import SwiftUI

struct FloatingTabView<Content: View, Value: CaseIterable & Hashable & FloatingTabProtocol>: View where Value.AllCases: RandomAccessCollection {
    @Binding var selection: Value
    @Binding var tabItems: [Value]
    @Binding var hideTabBar: Bool
    var config: FloatingTabConfig
    var content: (Value, CGFloat) -> Content
    
    init(config: FloatingTabConfig = .init(), selection: Binding<Value>, tabItems: Binding<[Value]>, hideTabBar: Binding<Bool>, @ViewBuilder content: @escaping (Value, CGFloat) -> Content) {
        self._selection = selection
        self._tabItems = tabItems
        self._hideTabBar = hideTabBar
        self.content = content
        self.config = config
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            if #available(iOS 18, *) {
                /// New Tab View
                TabView(selection: $selection) {
                    ForEach(Value.allCases, id: \.hashValue) { tab in
                        Tab.init(value: tab) {
                            content (tab, 0)
                            /// Hiding Native Tab Bar
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                    }
                }
            } else {
                /// Old Tab View
                TabView(selection: $selection) {
                    ForEach(Value.allCases, id: \.hashValue) { tab in
                        content (tab, 0)
                        /// Old tag type tab view
                            .tag(tab)
                        /// Hiding Native Tab Bar
                            .toolbar(.hidden, for: .tabBar)
                    }
                }
            }
            
            if !hideTabBar {
                floatingTabBar
                    .transition(.offset(y: 200))
            }
        }
    }
    
    var floatingTabBar: some View {
        FloatingTabBar(config: config, activeTab: $selection, tabItems: tabItems)
            .padding(.horizontal, 40)
            .padding(.bottom, config.insetAmount)
    }
}

#Preview {
    @Previewable @State var activeTab: TabBarItem = .home
    @Previewable @State var tabItems: [TabBarItem] = [.home, .search, .wishlist, .profile]
    
    FloatingTabView(selection: $activeTab, tabItems: $tabItems, hideTabBar: .constant(false), content: { tab, _ in
        switch tab {
        case .home: Text(TabBarItem.home.rawValue)
        case .search: Text(TabBarItem.search.rawValue)
        case .wishlist: Text(TabBarItem.wishlist.rawValue)
        case .profile: Text(TabBarItem.profile.rawValue)
        }
    })
}
