//
//  WidgetModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 18/05/25.
//

import SwiftUI


struct CarouselWidgetModel: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var viewType: CarouselViewType
}

enum CarouselViewType: String {
    case cover
    case ambient
    case parallax
}

extension CarouselViewType {
    @ViewBuilder
    func widgetView() -> some View {
        switch self {
        case .cover:
            CoverCarouselWidget()
        case .ambient:
            AmbientCarouselWidget()
        case .parallax:
            ParallaxCarouselWidget()
        }
    }
}
