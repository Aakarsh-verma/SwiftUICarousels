//
//  CardModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 28/05/25.
//

import SwiftUI

struct CardModel: Identifiable, Hashable {
    let id: UUID = UUID()
    var image: CustomImageModel = CustomImageModel(for: "m5")
    var season: String = "Brazil"
    var title: String = "Rio de Janeiro"
    var rating: String = "5.0"
    var review: String = "143"
    var episodes: String = "12"
    var status: String = "Finished"
    var description: String = "Rio de Janeiro, often simply called Rio, is one of Brazil’s most iconic cities, renowned for…"
    var isWishlisted: Bool = false
}
