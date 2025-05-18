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

enum NetworkError: Error {
    case typeCheckFailed
}
