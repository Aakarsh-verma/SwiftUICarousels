//
//  WidgetModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 18/05/25.
//

import SwiftUI


struct CarouselWidgetModel: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var viewType: CarouselViewType
    var dataType: CarouselDataType? = .imageModel
}

enum CarouselViewType: String {
    case cover
    case ambient
    case parallax
    case stack
}

enum CarouselDataType: String {
    case imageModel
    case cardModel
    case tripModel
}
