//
//  AppViewModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 28/07/25.
//

import SwiftUI
import CoreData

class AppViewModel: ObservableObject {
    static let shared = AppViewModel()
    let favorites: any StoredDataRepositoryProtocol<CardModel>
    
    private init() {
        self.favorites = FavoriteAnimeDataRepository()
    }
    
    func fetchFavorites(context: NSManagedObjectContext) async {
        await favorites.fetch(context: context)
    }
    
    func saveFavoriteAnime(context: NSManagedObjectContext) async {
        await favorites.save(context: context)
    }
    
    func addCard(_ card: CardModel) async {
        await favorites.addItem(card)
    }
    
    func removeCard(_ card: CardModel) async {
        await favorites.removeItem(card)
    }
}
