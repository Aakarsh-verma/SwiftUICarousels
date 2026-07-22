//
//  CacheServiceRepository.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 22/07/26.
//


protocol CacheServiceRepositoryProtocol<Item> {
    associatedtype Item: Decodable
    func getContent(for key: String) -> Item?
    func setContent(_ content: Item?, for key: String)
}

class AnimeCacheService: CacheServiceRepositoryProtocol {
    private var storage: [String: AnimeResponseModel] = [:]

    func getContent(for key: String) -> AnimeResponseModel? {
        return storage[key]
    }

    func setContent(_ content: AnimeResponseModel?, for key: String) {
        storage[key] = content
    }
}
