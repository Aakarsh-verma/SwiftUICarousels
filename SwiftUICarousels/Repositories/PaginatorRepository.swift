//
//  PaginatorRepository.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 31/07/26.
//

import SwiftUI

protocol PaginatorProtocol {
    associatedtype T: Identifiable
    associatedtype P: Decodable, Encodable
    var pagination: P? { get set }
    func loadInitialContent(for router: APIRouter) async -> [T]
    func loadNextPage() async -> [T]
}
