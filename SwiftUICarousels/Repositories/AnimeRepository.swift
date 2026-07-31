//
//  AnimeRepository.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/07/26.
//

import SwiftUI

protocol AnimeRepositoryProtocol: PaginatorProtocol where T == CardModel, P == Pagination {
    var favorite: [CardModel] { get set }
    var animeImages: [ImageModel] { get }
}

extension AnimeRepositoryProtocol {
    var pagination: Pagination? {
        return nil
    }
}

final class AnimeRepository: AnimeRepositoryProtocol {
    private let favoritesRepository: any StoredDataRepositoryProtocol<CardModel>
    private let datasource: any DataSourceRepositoryProtocol
    var favorite: [CardModel] = []
    var animeImages: [ImageModel] = []
    var pagination: Pagination? = nil 
    
    init() {
        self.favoritesRepository = AppViewModel.shared.favorites
        self.datasource = AnimeDataSourceRepository()
    }
    
    func loadInitialContent(for router: APIRouter) async -> [CardModel] {
        async let favoriteRequest = self.favoritesRepository.getItems()
        async let animeRequest = datasource.getData(router) as? AnimeResponseModel
        let (favorites, response) = await (favoriteRequest, animeRequest)
        self.pagination = response?.pagination
        self.favorite = favorites
        self.animeImages = response?.data?.map { ImageModel(image: $0.images?.mediumImageURL ?? "") } ?? []
        return self.configureContentCards(with: response?.data ?? [])
    }
    
    func loadNextPage() async -> [CardModel] {
        guard let pagination else { return [] }
        async let animeRequest = datasource.getMoreData(pagination.nextURL ?? "") as? AnimeResponseModel
        guard let response = await animeRequest else {
            return []
        }
        self.pagination = response.pagination
        return self.configureContentCards(with: response.data ?? [])
    }
    
    private func configureContentCards(with data: [AnimeData]) -> [CardModel] {
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
                image: CustomImageModel(for: anime.images?.mediumImageURL ?? ""),
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
