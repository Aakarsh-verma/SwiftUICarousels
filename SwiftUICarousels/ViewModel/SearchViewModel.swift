//
//  SearchViewModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 15/07/25.
//

import SwiftUI
import Observation

protocol SearchViewModelProtocol: AnyObject {
    var animeCards: [CardModel] { get set }
    var filters: [FilterTabsModel] { get set }
    var isLoadingNextPage: Bool { get set }
    func fetchInitialPage() async
    func fetchMoreContent() async
    func fetchSearchAnimeContent(for query: String) async
    func fetchFilterAnimeContent(for status: AiringStatus, by order: SortingOrder) async
}

@Observable
class SearchViewModel: SearchViewModelProtocol {
    var animeCards: [CardModel] = []
    var filters: [FilterTabsModel] = [
        .init(
            item: .init(
                text: "Reverse",
                leftImage: "",
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
                leftImage: "",
                color: .white,
                secondaryColor: .black,
                borderType: .roundRect(
                    radius: 20
                ),
                type: .status
            )
        ),
    ]
    @ObservationIgnored private let animeRepository: any AnimeRepositoryProtocol
    @ObservationIgnored private var initialPageloaded: Bool = false
    var isLoadingNextPage: Bool = false
    
    init(_ animeRepository: any AnimeRepositoryProtocol = AnimeRepository()) {
        self.animeRepository = animeRepository
    }
    
    @MainActor
    func fetchInitialPage() async {
        let contentType: APIRouter = .season((year: "2025", season: .spring))
        self.animeCards = await animeRepository.loadInitialContent(for: contentType)
        initialPageloaded.toggle()
    }
    
    @MainActor
    func fetchMoreContent() async {
        guard !isLoadingNextPage, animeRepository.pagination?.hasNextPage == true else { return }
        isLoadingNextPage = true
        defer { isLoadingNextPage = false }
        self.animeCards.append(contentsOf: await animeRepository.loadNextPage())
    }
    
    @MainActor
    func fetchSearchAnimeContent(for query: String) async {
        let router: APIRouter = .search(query: query)
        self.animeCards = await animeRepository.loadInitialContent(for: router)
    }
    
    @MainActor
    func fetchFilterAnimeContent(for status: AiringStatus = .airing, by order: SortingOrder = .asc) async {
        let router: APIRouter = .filter(sort: order, status: status)
        self.animeCards = await animeRepository.loadInitialContent(for: router)
    }
}
