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
    private let store = AnimeCardStore()
    
    func fetchFavorites(context: NSManagedObjectContext) async {
        let request: NSFetchRequest<AnimeDataModel> = AnimeDataModel.fetchRequest()
        do {
            let results = try context.fetch(request)
            if let content = results.first {
                await store.set(content.loadAnimeList())
            }
        } catch {
            print("Failed to fetch anime: \(error)")
        }
    }
    
    func saveFavoriteAnime(context: NSManagedObjectContext) async {
        let favorites = await store.get()
        let request: NSFetchRequest<AnimeDataModel> = AnimeDataModel.fetchRequest()
        do {
            let results = try context.fetch(request)
            if let content = results.first {
                content.saveAnimeList(favorites)
                content.saveContext()
            }
        } catch {
            print("Failed to save anime: \(error)")
        }
    }
    
    // Add accessors if needed:
    func getAnimeCards() async -> [CardModel] {
        await store.get()
    }
    
    func addCard(_ card: CardModel) async {
        await store.append(card)
    }
    
    func removeCard(_ card: CardModel) async {
        await store.remove(card: card)
    }
}

actor AnimeCardStore {
    private var cards: [CardModel] = []

    func get() -> [CardModel] {
        cards
    }

    func set(_ newCards: [CardModel]) {
        cards = newCards
    }

    func append(_ card: CardModel) {
        cards.append(card)
    }
    
    func remove(card: CardModel) {
        cards.removeAll { $0.id == card.id }
    }

    var count: Int {
        cards.count
    }
}
