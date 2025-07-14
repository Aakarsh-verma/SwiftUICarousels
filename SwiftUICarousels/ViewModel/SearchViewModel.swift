//
//  SearchViewModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 15/07/25.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var animeCards: [CardModel] = []
    
    private let service: NetworkService
    private let contentType: APIRouter
    
    init(service: NetworkService = APIService(), contentType: APIRouter = .season((year: "2025", season: .spring))) {
        self.service = service
        self.contentType = contentType
    }
    
    @MainActor
    func fetchAnimeContent() async {
        do {
            let response: AnimeResponseModel = try await service.request(contentType)
            let animes = response.data ?? []
            self.configureContentCards(with: animes)
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
                             review: review,
                             episodes: String(anime.episodes ?? 0),
                             status: anime.status ?? "",
                             description: anime.synopsis ?? "")
        }
    }
}
