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

extension AnimeSeason {
    static func current(from date: Date = .now) -> AnimeSeason {
        let month = Calendar.current.component(.month, from: date)
        
        switch month {
        case 1...3:
            return .winter
            
        case 4...6:
            return .spring
            
        case 7...9:
            return .summer
            
        default:
            return .autumn
        }
    }
    
    static var currentContext: AnimeSeasonContext {
        let calendar = Calendar.current
        let date = Date()

        return AnimeSeasonContext(
            year: String(calendar.component(.year, from: date)),
            season: current()
        )
    }
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

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIRouter {
    case seasonNow
    case season(AnimeSeasonContext)
    case ranking(AnimeRanking)
    case recommendation
    case search(query: String)
    case filter(sort: SortingOrder, status: AiringStatus)
    case pagination(url: URL)
}

extension APIRouter {
    private var completeURL: URL? {
        switch self {
        case .pagination(let url):
            return url
        default:
            return nil
        }
    }
    
    private var baseURL: String {
        return "https://api.myanimelist.net/v2/"
    }
    
    private var headers: [String: String] {
        return [
            "Content-Type": "application/json",
            "X-MAL-CLIENT-ID": AppConfiguration.malClientID
        ]
    }

    private var path: String {
        switch self {
        case .seasonNow:
            let context = AnimeSeason.currentContext
            return "anime/season/\(context.year)/\(context.season.rawValue)"
        case .season(let context):
            return "anime/season/\(context.year)/\(context.season.rawValue)"
        case .ranking:
            return "anime/ranking"
        case .recommendation:
            return "recommendations/anime"
        case .search, .filter:
            return "anime"
        case .pagination:
            return ""
        }
    }
    
    private var method: HTTPMethod {
        return .get
    }
    
    private var dataFields: String {
        return "id,title,synopsis,broadcast,mean,rank,popularity,rating,status,genres,source,studios,main_picture,alternative_titles,start_date, end_date,num_scoring_users,created_at,updated_at,media_type,num_episodes,start_season"
    }
    
    private var queryParams: [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        switch self {
        case .season:
            queryItems.append(URLQueryItem(name: "limit", value: "20"))

        case .ranking(let ranking):
            queryItems.append(URLQueryItem(name: "ranking_type", value: ranking.rawValue))
            queryItems.append(URLQueryItem(name: "limit", value: "20"))
            
        case .search(let query):
            queryItems.append(URLQueryItem(name: "q", value: query))
            queryItems.append(URLQueryItem(name: "limit", value: "20"))
            
        case .filter(let sort, let status):
            queryItems.append(URLQueryItem(name: "status", value: status.rawValue))
            queryItems.append(URLQueryItem(name: "sort", value: sort.rawValue))
            
        case .pagination:
            return []
            
        default:
            break
        }
        queryItems.append(URLQueryItem(name: "fields", value: dataFields))
        return queryItems
    }
    
    var routerKey: String? {
        guard let components = URLComponents(string: baseURL + path) else {
            return nil
        }
        return components.url?.absoluteString
    }
    
    /**  
     Generate URLRequest based on router
     - Sample cURL:  curl 'https://api.myanimelist.net/v2/anime/ranking?ranking_type=all&limit=4' \
     **/
    func asURLRequest() throws -> URLRequest {
        if let url = self.completeURL {  return buildRequest(url) }
        
        guard var components = URLComponents(string: baseURL + path) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = queryParams
        guard let url = components.url else { throw URLError(.badURL) }
        return buildRequest(url)
    }
    
    private func buildRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.httpMethod = method.rawValue
        return request
    }
}
