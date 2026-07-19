//
//  AnimeCardStore.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/07/26.
//

import Foundation

protocol ContentStorageProtocol<Item>: Actor {
    associatedtype Item: Identifiable

    var count: Int { get }
    func get() -> [Item]
    func set(_ items: [Item])
    func append(_ item: Item)
    func remove(_ item: Item)
}

actor AnimeCardStore: ContentStorageProtocol {
    private var cards: [CardModel] = []
    var count: Int { cards.count }

    func get() -> [CardModel] {
        cards
    }

    func set(_ items: [CardModel]) {
        cards = items
    }

    func append(_ item: CardModel) {
        cards.append(item)
    }
    
    func remove(_ item: CardModel) {
        cards.removeAll { $0.id == item.id }
    }
}
