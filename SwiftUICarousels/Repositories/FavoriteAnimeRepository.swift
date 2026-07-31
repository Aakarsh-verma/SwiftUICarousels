//
//  FavoriteAnimeRepository.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/07/26.
//

import SwiftUI
import CoreData

class FavoriteAnimeDataRepository: StoredDataRepositoryProtocol {
    private var store: any ContentStorageProtocol<CardModel>
    init() {
        self.store = AnimeCardStore()
    }
    
    func fetch(context: NSManagedObjectContext) async {
        let request: NSFetchRequest<AnimeDataModel> = AnimeDataModel.fetchRequest()
        do {
            let results = try context.fetch(request)
            if let content = results.first {
                await store.set(content.loadAnimeList())
            }
        } catch {
            CustomLogger.shared.debugLog("Failed to fetch anime: \(error)")
        }
    }
    
    func save(context: NSManagedObjectContext) async {
        let favorites = await store.get()
        let request: NSFetchRequest<AnimeDataModel> = AnimeDataModel.fetchRequest()
        do {
            let results = try context.fetch(request)
            if let content = results.first {
                content.saveAnimeList(favorites)
                content.saveContext()
            }
        } catch {
            CustomLogger.shared.debugLog("Failed to save anime: \(error)")
        }
    }
    
    func getItems() async -> [CardModel] {
        await store.get()
    }
    
    func addItem(_ card: CardModel) async {
        await store.append(card)
    }
    
    func removeItem(_ card: CardModel) async {
        await store.remove(card)
    }
}
