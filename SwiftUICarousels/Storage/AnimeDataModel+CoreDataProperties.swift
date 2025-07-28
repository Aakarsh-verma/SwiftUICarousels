//
//  AnimeDataModel+CoreDataProperties.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 28/07/25.
//
//

import Foundation
import CoreData


extension AnimeDataModel {
    @NSManaged public var animeContent: Data?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnimeDataModel> {
        return NSFetchRequest<AnimeDataModel>(entityName: "AnimeDataModel")
    }
    
    func saveContext() {
        do {
            try self.managedObjectContext?.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    func saveAnimeList(_ list: [CardModel]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(list)
            self.animeContent = data
        } catch {
            print("Encoding failed: \(error)")
        }
    }
    
    func loadAnimeList() -> [CardModel] {
        guard let data = animeContent else { return [] }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode([CardModel].self, from: data)
        } catch {
            print("Decoding failed: \(error)")
            return []
        }
    }

}

extension AnimeDataModel : Identifiable {

}
