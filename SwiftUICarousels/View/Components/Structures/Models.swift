//
//  Models.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 12/07/25.
//

import SwiftUI

typealias ActionCallback = () -> Void

enum ComponentType: String {
    case primary
    case secondary
    case tertiary
}

enum ComponentDimension: CGFloat {
    case XSmall = 8
    case Small = 16
    case Regular = 24
    case Large = 32
    case XLarge = 40
    case XXLarge = 48
}

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

struct IconModel {
    let name: String
    let type: ComponentType
    let size: ComponentDimension
    let color: Color
    let style: AnyShapeStyle?
    let bgColor: Color
    var tapAction: ActionCallback?
    
    init(name: String,
         type: ComponentType = .primary,
         size: ComponentDimension? = nil,
         color: Color? = nil,
         style: AnyShapeStyle? = nil,
         bgColor: Color? = nil,
         tapAction: ActionCallback? = nil) {
        self.name = name
        self.type = type
        self.size = size ?? .Regular
        self.color = color ?? .black
        self.style = style ?? AnyShapeStyle(.clear)
        self.bgColor = type == .primary ? (bgColor ?? .clear) : .clear
        self.tapAction = tapAction
    }
}
