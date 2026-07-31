//
//  StoredDataRepositoryProtocol.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 31/07/26.
//

import Foundation
import CoreData

protocol StoredDataRepositoryProtocol<Item> {
    associatedtype Item: Identifiable    
    func getItems() async -> [Item]
    func addItem(_ item: Item) async
    func removeItem(_ item: Item) async
    func fetch(context: NSManagedObjectContext) async
    func save(context: NSManagedObjectContext) async
}
