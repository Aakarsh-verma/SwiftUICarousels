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
    
    private let service: NetworkService
    private let contentType: APIRouter
    
    init(service: NetworkService = APIService(), contentType: APIRouter = .season((year: "2014", season: .spring))) {
        self.service = service
        self.contentType = contentType
    }
    
    @MainActor
    func fetchAnimeContent() async {
        do {
            let response: AnimeResponseModel = try await service.request(contentType)
            let animes = response.data ?? []
            self.configureContentCards(with: animes)
            self.animeImages = animes.map { ImageModel(image: ($0.images?["jpg"]?.imageURL ?? "")) }
        } catch {
            print("API Error:", error)
        }
    }
    
    @MainActor
    func configureContentCards(with data: [AnimeData]) {
        animeCards = data.compactMap { anime in
            let rating = (anime.score != nil) ? String(anime.score ?? 0.0) : "-"
            let review = anime.scoredBy?.formatCount() ?? ""
            let season = (anime.season ?? "").uppercased() + ", " + anime.year.toString()
            return CardModel(image: CustomImageModel(for: (anime.images?["jpg"]?.imageURL ?? "")),
                             season: season,
                             title: anime.titleEnglish ?? anime.title ?? anime.titleJapanese ?? "",
                             rating: rating,
                             review: review)
        }
    }
}
