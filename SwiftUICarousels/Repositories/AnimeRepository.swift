//
//  AnimeRepository.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/07/26.
//

import SwiftUI

protocol AnimeRepositoryProtocol {
    var favorite: [CardModel] { get set }
    var animeImages: [ImageModel] { get }
    func getAnimeCards(_ contentType: APIRouter) async -> [CardModel]
}


final class AnimeRepository: AnimeRepositoryProtocol {
    private let service: NetworkService
    private let favoritesRepository: any StoredDataRepositoryProtocol
    var favorite: [CardModel] = []
    var animeImages: [ImageModel] = []
    
    init() {
        self.service = APIService()
        self.favoritesRepository = FavoriteAnimeDataRepository()
    }
    
    func getAnimeCards(_ contentType: APIRouter) async -> [CardModel] {
        do {
            async let favoriteRequest = self.favoritesRepository.getItems()
            async let animeRequest: AnimeResponseModel = service.request(contentType)
            let (favorites, response) = try await (favoriteRequest, animeRequest)
            self.favorite = favorites as! [CardModel]
            self.animeImages = response.data?.map { ImageModel(image: ($0.images?["jpg"]?.imageURL ?? "")) } ?? []
            return self.configureContentCards(with: response.data ?? [])
        } catch {
            CustomLogger.shared.debugLog("API Error: \(error)")
            return []
        }
    }
    
    func configureContentCards(with data: [AnimeData]) -> [CardModel] {
        var seenTitles = Set<String>()
        var animeCards: [CardModel] = []

        for anime in data {
            let title = anime.titleEnglish ?? anime.title ?? anime.titleJapanese ?? ""
            if seenTitles.contains(title) { continue }
            seenTitles.insert(title)

            let rating = (anime.score != nil) ? String(anime.score ?? 0.0) : "-"
            let review = anime.scoredBy?.formatCount() ?? ""
            let season = (anime.season ?? "").uppercased() + ", " + anime.year.toString()
            let isFavorite = favorite.filter { $0.title == title }

            let card = CardModel(
                image: CustomImageModel(for: (anime.images?["jpg"]?.imageURL ?? "")),
                season: season,
                title: title,
                rating: rating,
                review: review,
                episodes: String(anime.episodes ?? 0),
                status: anime.status ?? "",
                description: anime.synopsis ?? "",
                isFavorite: !isFavorite.isEmpty
            )
            animeCards.append(card)
        }
        return animeCards
    }
}
