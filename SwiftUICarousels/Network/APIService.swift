//
//  APIService.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/05/25.
//

import SwiftUI

class APIService: NetworkService {
    func request<T: Decodable>(_ router: APIRouter) async throws -> T {
        let request = try router.asURLRequest()
        
        print("API REQUEST URL \(request.url?.absoluteString ?? "")")
        
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            if let urlError = error as? URLError {
                throw NetworkError.urlError(urlError)
            } else {
                throw error
            }
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown(statusCode: -1)
        }

        return try parseAPIResponse(data, httpResponse: httpResponse)
    }
    
    private func parseAPIResponse<T: Decodable>(_ data: Data, httpResponse: HTTPURLResponse) throws -> T {
        switch httpResponse.statusCode {
        case 200..<300:
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError
            }

        default:
            if let apiError = try? JSONDecoder().decode(NetworkErrorResponse.self, from: data) {
                throw NetworkError.apiError(apiError)
            } else {
                throw NetworkError.unknown(statusCode: httpResponse.statusCode)
            }
        }
    }
}

