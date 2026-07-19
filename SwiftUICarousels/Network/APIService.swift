//
//  APIService.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/05/25.
//

import Foundation

final class APIService: NetworkService {
    var session: URLSession
    var decoder: JSONDecoder
    
    init(session: URLSession = URLSession(configuration: .default), 
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func request<T: Decodable>(_ router: APIRouter) async throws -> T {
        let request = try router.asURLRequest()
        
        CustomLogger.shared.debugLog(request.url?.absoluteString ?? "")
        
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            if let urlError = error as? URLError {
                throw NetworkError.urlError(urlError)
            } else {
                throw error
            }
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        return try parseAPIResponse(data, httpResponse: httpResponse)
    }
    
    private func parseAPIResponse<T: Decodable>(_ data: Data, httpResponse: HTTPURLResponse) throws -> T {
        switch httpResponse.statusCode {
        case 200..<300:
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError
            }
            
        default:
            if let apiError = try? decoder.decode(NetworkErrorResponse.self, from: data) {
                throw NetworkError.apiError(apiError)
            } else {
                throw NetworkError.unknown(statusCode: httpResponse.statusCode)
            }
        }
    }
}

