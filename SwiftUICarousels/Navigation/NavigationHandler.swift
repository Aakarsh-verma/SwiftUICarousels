//
//  NavigationHandler.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 18/05/25.
//

import SwiftUI

enum CarouselPageEnum: String {
    case home
    case cover
    case ambient
    case parallax
}

class NavigationHandler {
    static let shared = NavigationHandler()
    
    @ViewBuilder
    func performNavigation(_ route: String) -> some View {
        let destination = CarouselPageEnum(rawValue: route) ?? .home
        navigate(to: destination)
    }
    
    @ViewBuilder
    func navigate(to destination: CarouselPageEnum) -> some View {
        switch destination {
        case .cover: CoverCarousel()
        case .ambient: AmbientCarousel()
        case .parallax: ParallaxCarousel()
        default: ContentView()
        }
    }
}
