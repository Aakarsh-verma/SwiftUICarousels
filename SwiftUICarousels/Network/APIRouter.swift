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

enum SortingOrder: String {
    case desc 
    case asc 
}

enum AiringStatus: String {
    case airing
    case complete
    case upcoming
}

enum AnimeRanking: String {
    case all                /// Top Anime Series
    case airing             /// Top Airing Anime
    case upcoming           /// Top Upcoming Anime
    case tv                 /// Top Anime TV Series
    case ova                /// Top Anime OVA Series
    case movie              /// Top Anime Movies
    case special            /// Top Anime Specials
    case bypopularity       /// Top Anime by Popularity
    case favorite           /// Top Favorited Anime
}

typealias AnimeSeasonContext = (year: String, season: AnimeSeason)

enum APIRouter {
    case seasonNow
    case season(AnimeSeasonContext)
    case ranking(AnimeRanking)
    case recommendation
    case search(query: String)
    case filter(sort: SortingOrder, status: AiringStatus)
}

extension APIRouter {
    var baseURL: String {
        return "https://api.myanimelist.net/v2/"
    }
    
    var headers: [String: String] {
        return [
            "Content-Type": "application/json",
            "X-MAL-CLIENT-ID": AppConfiguration.malClientID
        ]
    }
//    curl 'https://api.myanimelist.net/v2/anime/ranking?ranking_type=all&limit=4' \

    var path: String {
        switch self {
        case .seasonNow:
            return "seasons/now"
        case .season(let context):
            return "anime/season/\(context.year)/\(context.season.rawValue)"
        case .ranking:
            return "anime/ranking"
        case .recommendation:
            return "recommendations/anime"
        case .search, .filter:
            return "anime"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var dataFields: String {
        return "id,title,synopsis,broadcast,mean,rank,popularity,rating,status,genres,source,studios,main_picture,alternative_titles,start_date, end_date,num_scoring_users,created_at,updated_at,media_type,num_episodes,start_season"
    }
    
    var queryParams: [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        switch self {
        case .season:
            queryItems.append(URLQueryItem(name: "limit", value: "10"))

        case .ranking(let ranking):
            queryItems.append(URLQueryItem(name: "ranking_type", value: ranking.rawValue))
            queryItems.append(URLQueryItem(name: "limit", value: "10"))
            
        case .search(let query):
            queryItems.append(URLQueryItem(name: "q", value: query))
            queryItems.append(URLQueryItem(name: "limit", value: "10"))
            
        case .filter(let sort, let status):
            queryItems.append(URLQueryItem(name: "status", value: status.rawValue))
            queryItems.append(URLQueryItem(name: "sort", value: sort.rawValue))
            
        default:
            break
        }
        queryItems.append(URLQueryItem(name: "fields", value: dataFields))
        return queryItems
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
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.httpMethod = method
        return request
    }
}
