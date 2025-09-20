//
//  FloatingTabBar.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 25/05/25.
//

import SwiftUI

struct FloatingTabBar<Value: Hashable & FloatingTabProtocol>: View {
    var config: FloatingTabConfig
    @Binding var activeTab: Value
    var tabItems: [Value]
    @Namespace private var animation
    @State private var toggleSymbolEffect: [Bool]

    init(config: FloatingTabConfig, activeTab: Binding<Value>, tabItems: [Value]) {
        self.config = config
        self._activeTab = activeTab
        self.tabItems = tabItems
        self._toggleSymbolEffect = State(initialValue: Array(repeating: false, count: tabItems.count))
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(tabItems.enumerated()), id: \.1.hashValue) { index, tab in
                let isActive = tab == activeTab
                let isFill = isActive && (tab.symbolImage != TabBarItem.search.symbolImage)
                
                Image(systemName: isFill ? tab.symbolImage + ".fill" : tab.symbolImage)
                    .font(.title)
                    .foregroundStyle(isActive ? config.activeTint : config.inactiveTint)
                    .symbolEffect(.bounce.byLayer.down, value: toggleSymbolEffect[index])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(.rect)
                    .background {
                        if isActive {
                            Circle()
                                .fill(config.activeBackgroundTint.gradient)
                                .frame(width: 60, height: 60)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .radialTapGesture {
                        activeTab = tab
                        toggleSymbolEffect[index].toggle()
                    }
            }
        }
        .padding(.horizontal)
        .frame(height: 80)
        .background(tabBarBackground)
        .clipShape(.capsule(style: .continuous))
        .animation(config.tabAnimation, value: activeTab)
    }

    var tabBarBackground: some View {
        ZStack {
            if config.isTranslucent {
                Rectangle().fill(.ultraThinMaterial)
            } else {
                Rectangle().fill(.background)
            }
            Rectangle().fill(config.backgroundColor)
        }
    }
}
