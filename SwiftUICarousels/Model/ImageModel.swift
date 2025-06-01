//
//  ImageModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 04/05/25.
//

import SwiftUI


struct CustomImageModel: Identifiable, Hashable {
    let id: UUID = UUID()
    var image: String
    
    var isRemoteImage: Bool {
        return image.hasPrefix("http") || image.hasPrefix("https")
    }
    
    var isAssetImage: Bool {
        return UIImage(named: image) != nil
    }
    
    init(for image: String) {
        self.image = image
    }
}

struct ImageModel: Identifiable {
    var id: UUID = UUID()
    var image: String
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
