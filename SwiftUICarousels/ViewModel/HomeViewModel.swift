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
    
    @Published var animeImages: [ImageModel] = []
    
    private let service: NetworkService
    
    init(service: NetworkService = APIService()) {
        self.service = service
    }
    
    @MainActor
    func fetchAnimeContent() async {
        do {
            let response: AnimeResponseModel = try await service.request(.spring)
            let animes = response.data ?? []
            self.animeImages = animes.map { ImageModel(image: ($0.images?["jpg"]?.imageURL ?? "")) }
        } catch {
            print("API Error:", error)
        }
    }
}
