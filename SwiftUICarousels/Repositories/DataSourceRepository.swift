//
//  DataSourceRepository.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 22/07/26.
//

import Foundation

protocol DataSourceRepositoryProtocol {
    associatedtype Content: Decodable
    func getData(_ router: APIRouter) async -> Content?
}

class AnimeDataSourceRepository: DataSourceRepositoryProtocol {
    var service: NetworkServiceProtocol
    var cache: any CacheServiceRepositoryProtocol<AnimeResponseModel>

    init() {
        self.service = APIService()
        self.cache = AnimeCacheService()
    }

    func getData(_ router: APIRouter) async -> AnimeResponseModel? {
        if let routerKey = router.routerKey, 
            let data = await cache.getContent(for: routerKey) {
            return data
        }

        do {
            let data: AnimeResponseModel? = try await service.request(router)
            if let routerKey = router.routerKey {
                await cache.setContent(data, for: routerKey)
            }
            return data
        } catch {
            CustomLogger.shared.debugLog("AnimeDataSourceRepository Failed to fetch data: \(error)")
            return nil
        }
    }
}
