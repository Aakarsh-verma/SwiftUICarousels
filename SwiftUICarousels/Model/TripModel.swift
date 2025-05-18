//
//  TripModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 18/05/25.
//

import SwiftUI


struct TripModel: Identifiable, Hashable {
    let id: UUID = UUID()
    var title: String
    var subtitle: String
    var image: String
}

var trips: [TripModel] = [
    .init(title: "Vegas", subtitle: "USA", image: "citi1"),
    .init(title: "Copenhagen", subtitle: "Denmark", image: "citi2"),
    .init(title: "Prague", subtitle: "Czech Republic", image: "citi3"),
    .init(title: "Venice", subtitle: "Italy", image: "citi4"),
    .init(title: "Budapest", subtitle: "Hungary", image: "citi5"),
    .init(title: "Sakura", subtitle: "Japan", image: "citi6"),
    .init(title: "Himalayas", subtitle: "India", image: "citi7"),
]
