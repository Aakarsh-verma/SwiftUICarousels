//
//  APIService.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/05/25.
//

import Foundation

final class APIService: NetworkServiceProtocol {
    var session: URLSession
    var decoder: JSONDecoder
    
    init(session: URLSession = URLSession(configuration: .default), 
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func request<T: Decodable>(_ router: APIRouter) async throws -> T? {
        let request = try router.asURLRequest()
        
        CustomLogger.shared.debugLog("NETWORK:- REQUEST \n \(request)")
        
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            CustomLogger.shared.debugLog("NETWORK:- CALL Error \n \(error)")
            if let urlError = error as? URLError {
                throw NetworkError.urlError(urlError)
            } else {
                throw error
            }
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            CustomLogger.shared.debugLog("NETWORK:- RESPONSE Error")
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
                CustomLogger.shared.debugLog("NETWORK:- PARSING Error \n \(error)")
                if error is DecodingError {
                    throw NetworkError.decodingError
                } else {
                    throw NetworkError.unknown(statusCode: httpResponse.statusCode)
                }
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

