//
//  NetworkManager.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/05/25.
//

import SwiftUI


protocol NetworkService {
    func request<T: Decodable>(_ router: APIRouter) async throws -> T
}

struct NetworkErrorResponse: Decodable {
    let status: Int
    let type: String?
    let message: String?
    let error: String?
    let report_url: String?
}

enum NetworkError: LocalizedError {
    case apiError(NetworkErrorResponse)
    case decodingError
    case urlError(URLError)
    case unknown(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .apiError(let response):
            return response.message ?? "An unknown API error occurred."
        case .decodingError:
            return "Failed to decode the response."
        case .urlError(let err):
            return err.localizedDescription
        case .unknown(let code):
            return "Unexpected status code: \(code)"
        }
    }
}
