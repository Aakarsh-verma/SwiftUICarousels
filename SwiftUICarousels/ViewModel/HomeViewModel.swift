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
        .init(title: "Stack Carousel", viewType: .stack),
        .init(title: "Parallax Carousel", viewType: .parallax),
        .init(title: "Ambient Carousel", viewType: .ambient)
    ]
    
    @Published var dashboardWidgets: [CarouselWidgetModel] = [
        .init(title: "Stack Carousel", viewType: .stack, dataType: .cardModel),
    ]
    
    @Published var animeImages = [ImageModel]()
    @Published var animeCards: [CardModel] = []
    
    private let animeRepository: AnimeRepositoryProtocol
    
    init() {
        self.animeRepository = AnimeRepository()
    }
    
    @MainActor
    func fetchAnimeContent(_ season: AnimeSeasonContext = (year: "2014", season: .spring)) async {
        let contentType: APIRouter = .season(season)
        self.animeCards = await animeRepository.loadInitialContent(for: contentType)
        self.animeImages = animeRepository.animeImages
    }
}
