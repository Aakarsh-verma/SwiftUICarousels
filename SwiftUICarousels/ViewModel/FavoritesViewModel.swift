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
    
    func fetchFavorites(_ favorites: any StoredDataRepositoryProtocol<CardModel>) async {
        let cards = await favorites.getItems()
        await MainActor.run {
            animeCards = cards
        }
     }
}
