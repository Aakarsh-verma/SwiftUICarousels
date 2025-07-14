//
//  APIRouter.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/05/25.
//

import SwiftUI

enum AnimeSeason: String {
    case spring
    case summer
    case autumn
    case winter
}

typealias AnimeSeasonContext = (year: String, season: AnimeSeason)

enum APIRouter {
    case seasonNow
    case season(AnimeSeasonContext)
    case top
    case recommendation
    case search(query: String)
}

extension APIRouter {
    var baseURL: String {
        return "https://api.jikan.moe/v4/"
    }
    
    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    var path: String {
        switch self {
        case .seasonNow:
            return "seasons/now"
        case .season(let context):
            return "seasons/\(context.year)/\(context.season.rawValue)"
        case .top:
            return "top/anime"
        case .recommendation:
            return "recommendations/anime"
        case .search:
            return "anime"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var queryParams: [URLQueryItem] {
        switch self {
        case .search(let query):
            var queryItems = [URLQueryItem]()
            queryItems.append(URLQueryItem(name: "q", value: query))
            return queryItems
            
        default:
            return []
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard var components = URLComponents(string: baseURL + path) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = queryParams
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
