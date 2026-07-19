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
        .init(
            item: .init(
                text: "Reverse",
                leftImage: "slider.horizontal.3",
                color: .white,
                secondaryColor: .black,
                borderType: .roundRect(
                    radius: 20
                ),
                type: .sortOrder
            )
        ),
        .init(
            item: .init(
                text: "Airing",
                leftImage: "slider.horizontal.3",
                color: .white,
                secondaryColor: .black,
                borderType: .roundRect(
                    radius: 20
                ),
                type: .status
            )
        ),
    ]
    private let animeRepository: AnimeRepositoryProtocol
    
    init() {
        self.animeRepository = AnimeRepository()
    }
    
    @MainActor
    func fetchAnimeContent() async {
        let contentType: APIRouter = .season((year: "2025", season: .spring))
        self.animeCards = await animeRepository.getAnimeCards(contentType)
    }
    
    @MainActor
    func fetchSearchAnimeContent(for query: String) async {
        let router: APIRouter = .search(query: query)
        self.animeCards = await animeRepository.getAnimeCards(router)
    }
    
    @MainActor
    func fetchFilterAnimeContent(for status: AiringStatus = .airing, by order: SortingOrder = .asc) async {
        let router: APIRouter = .filter(sort: order, status: status)
        self.animeCards = await animeRepository.getAnimeCards(router)
    }
}
