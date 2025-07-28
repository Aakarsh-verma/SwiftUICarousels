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
    
    func fetchFavorites(context: NSManagedObjectContext) async {
        let cards = await AppViewModel.shared.getAnimeCards()
        await MainActor.run {
            animeCards = cards
        }
     }
}
