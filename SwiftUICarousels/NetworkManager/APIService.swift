//
//  APIService.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/05/25.
//

import SwiftUI

class APIService: NetworkService {
    func request<T>(_ router: APIRouter) async throws -> T where T : Decodable {
        let request = try router.asURLRequest()
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
    
    
}
