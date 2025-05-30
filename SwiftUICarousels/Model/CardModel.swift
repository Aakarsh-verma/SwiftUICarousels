//
//  CardModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 28/05/25.
//

import SwiftUI

struct CardModel: Identifiable {
    let id: UUID = UUID()
    var image: CustomImageModel = CustomImageModel(for: "m5")
    var season: String = "Brazil"
    var title: String = "Rio de Janeiro"
    var rating: String = "5.0"
    var review: String = "143"
}
