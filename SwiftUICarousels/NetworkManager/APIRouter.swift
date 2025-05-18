//
//  APIRouter.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/05/25.
//

import SwiftUI


public enum APIRouter {
    case spring
    case none
}

extension APIRouter {
    var baseURL: String {
        return "https://api.jikan.moe/v4/seasons/2014/"
    }
    
    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    var path: String {
        switch self {
        case .spring:
            return "spring?sfw&limit=10"
        case .none:
            return ""
        }
    }
    
    var method: String {
        return "GET"
    }
    
    func asURLRequest() throws -> URLRequest {
        guard var components = URLComponents(string: baseURL + path) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = .none
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
