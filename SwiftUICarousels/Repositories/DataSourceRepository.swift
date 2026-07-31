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
    func getMoreData(_ url: String) async -> Content?
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
    
    func getMoreData(_ paginationURL: String) async -> AnimeResponseModel? {
        guard let url = URL(string: paginationURL) else {
            CustomLogger.shared.debugLog(NetworkError.urlError(.init(.badURL)).localizedDescription)
            return nil
        }
        let router = APIRouter.pagination(url: url)
        do {
            let newData: AnimeResponseModel? = try await service.request(router)
            return newData
        } catch {
            CustomLogger.shared.debugLog("AnimeDataSourceRepository Failed to fetch data: \(error)")
            return nil
        }
    }
}
