//
//  FavoritesViewModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 28/07/25.
//

import SwiftUI
import CoreData

class FavoritesViewModel: ObservableObject {
    @Published var animeCards: [CardModel] = []
    private let favorites: any StoredDataRepositoryProtocol<CardModel>
    
    init() {
        self.favorites = FavoriteAnimeDataRepository()
    }
    
    func fetchFavorites(context: NSManagedObjectContext) async {
        let cards = await favorites.getItems()
        await MainActor.run {
            animeCards = cards
        }
     }
}
