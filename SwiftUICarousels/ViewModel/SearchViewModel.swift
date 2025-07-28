//
//  SearchViewModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 15/07/25.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var animeCards: [CardModel] = []
    @Published var filters: [FilterTabsModel] = [
        .init(item: .init(text: "Sort", leftImage: "slider.horizontal.3", color: .white, borderColor: .white, borderType: .roundRect(radius: 12))),
    ]
    var favorite: [CardModel] = []
    private let service: NetworkService
    private let contentType: APIRouter
    
    init(service: NetworkService = APIService(), contentType: APIRouter = .season((year: "2025", season: .spring))) {
        self.service = service
        self.contentType = contentType
    }
    
    @MainActor
    func fetchAnimeContent() async {
        do {
            favorite = await AppViewModel.shared.getAnimeCards()
            let response: AnimeResponseModel = try await service.request(contentType)
            let animes = response.data ?? []
            self.configureContentCards(with: animes)
        } catch {
            print("API Error:", error)
        }
    }
    
    @MainActor
    func fetchSearchAnimeContent(for query: String) async {
        let router: APIRouter = .search(query: query)
        do {
            let response: AnimeResponseModel = try await service.request(router)
            let animes = response.data ?? []
            self.configureContentCards(with: animes)
        } catch {
            print("API Error:", error)
        }
    }
    
    @MainActor
    func configureContentCards(with data: [AnimeData]) {
        var seenTitles = Set<String>()

        animeCards = data.compactMap { anime in
            let title = anime.titleEnglish ?? anime.title ?? anime.titleJapanese ?? ""
            guard !seenTitles.contains(title) else { return nil }
            seenTitles.insert(title)

            let rating = (anime.score != nil) ? String(anime.score ?? 0.0) : "-"
            let review = anime.scoredBy?.formatCount() ?? ""
            let season = (anime.season ?? "").uppercased() + ", " + anime.year.toString()
            let isFavorite = favorite.filter { $0.title == title }
            return CardModel(image: CustomImageModel(for: (anime.images?["jpg"]?.imageURL ?? "")),
                             season: season,
                             title: title,
                             rating: rating,
                             review: review,
                             episodes: String(anime.episodes ?? 0),
                             status: anime.status ?? "",
                             description: anime.synopsis ?? "",
                             isFavorite: !isFavorite.isEmpty)
        }
    }
}
