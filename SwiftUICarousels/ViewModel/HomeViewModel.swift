//
//  HomeViewModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 18/05/25.
//

import SwiftUI

@Observable
class HomeViewModel {
    var homeWidgets: [CarouselWidgetModel] = [
        .init(title: "Cover Carousel", viewType: .cover),
        .init(title: "Stack Carousel", viewType: .stack),
        .init(title: "Parallax Carousel", viewType: .parallax),
        .init(title: "Ambient Carousel", viewType: .ambient)
    ]
    
    var dashboardWidgets: [CarouselWidgetModel] = [
        .init(title: "Stack Carousel", viewType: .stack, dataType: .cardModel),
    ]
    
    var animeImages = [ImageModel]()
    var animeCards: [CardModel] = []
    
    private let animeRepository: any AnimeRepositoryProtocol
    
    init(_ animeRepository: any AnimeRepositoryProtocol = AnimeRepository()) {
        self.animeRepository = animeRepository
    }
    
    @MainActor
    func fetchAnimeContent(_ season: AnimeSeasonContext = (year: "2014", season: .spring)) async {
        let contentType: APIRouter = .season(season)
        self.animeCards = await animeRepository.loadInitialContent(for: contentType)
        self.animeImages = animeRepository.animeImages
    }
}
