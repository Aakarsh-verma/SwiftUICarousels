//
//  ImageModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 04/05/25.
//

import SwiftUI

struct ImageModel: Identifiable, CardPreviewContent {
    var id: UUID = UUID()
    var image: String
    
    func getPreviewData() -> PreviewDataModel? {
        return .init(image: CustomImageModel(for: image))
    }
}

var sampleImages: [ImageModel] = (1...9).compactMap { ImageModel(image: "m\($0)") }

struct Config {
    var hasOpacity: Bool = false
    var opacityValue: CGFloat = 0.4
    var hasScale: Bool = false
    var scaleValue: CGFloat = 0.2
    
    var cardWidth: CGFloat = 150
    var spacing: CGFloat = 10
    var cornerRadius: CGFloat = 15
    var minimumCardWidth: CGFloat = 40
}
