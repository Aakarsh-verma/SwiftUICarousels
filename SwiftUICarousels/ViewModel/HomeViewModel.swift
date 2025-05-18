//
//  HomeViewModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 18/05/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var homeWidgets: [CarouselWidgetModel] = [
        .init(title: "Cover Carousel", viewType: .cover),
        .init(title: "Parallax Carousel", viewType: .parallax),
        .init(title: "Ambient Carousel", viewType: .ambient)
    ]
}
