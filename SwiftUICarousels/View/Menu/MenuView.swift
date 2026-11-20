//
//  AcountView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 20/11/26.
//

import SwiftUI
/*
 1. Profile Image and Name as Header
 2. Favorites
 3. Theme Mode
 4. Background
 5. Rate Us
 6. App Version
 */

import SwiftUI

public let settingsGroups: [[MenuItemModel]] = [
    [
        .init(
            title: "Anime User",
            subtitle: "iOS Developer",
            icon: "placeholder",
            type: .profile
        )
    ],
    [
        .init(
            title: "Anime User",
            subtitle: "iOS Developer",
            icon: "placeholder",
            type: .insights
        )
    ],
    [
        .init(
            title: "Account",
            subtitle: "Profile, security and devices",
            icon: "person"
        ),
        .init(
            title: "Notifications",
            subtitle: "Push, email and in-app",
            icon: "bell"
        ),
        .init(
            title: "Appearance",
            subtitle: "Light, dark and theme",
            icon: "moon"
        )
    ],
    [
        .init(
            title: "Backup & Sync",
            subtitle: "iCloud and data sync",
            icon: "icloud"
        ),
        .init(
            title: "Data & Storage",
            subtitle: "Cache, downloads and usage",
            icon: "externaldrive"
        )
    ],
    [
        .init(
            title: "Preferences",
            subtitle: "App behaviour and advanced",
            icon: "slider.horizontal.3"
        ),
        .init(
            title: "Help & Support",
            subtitle: "FAQs and contact us",
            icon: "questionmark.circle"
        ),
        .init(
            title: "About",
            subtitle: "Version 1.0 (100)",
            icon: "info.circle"
        )
    ]
]

// MARK: - Main Screen

struct MenuView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private var dark: Bool {
        colorScheme == .dark
    }

    var body: some View {
        ZStack {
            ClayTheme.background(dark)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    MenuHeaderView()

                    ForEach(settingsGroups.indices, id: \.self) { index in
                        MenuSectionItem(items: settingsGroups[index])
                    }
                }
                .padding(.horizontal, 22)
                .padding(.top, 20)
                .padding(.bottom, 45)
            }
            .scrollIndicators(.hidden)
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Preview

#Preview("Light") {
    MenuView()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    MenuView()
        .preferredColorScheme(.dark)
}
