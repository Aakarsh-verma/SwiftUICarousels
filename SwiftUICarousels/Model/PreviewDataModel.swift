//
//  PreviewDataModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 26/10/25.
//

import Foundation

struct PreviewDataModel {
    var image: CustomImageModel?
    var title: String?
    var description: String?
}

protocol CardPreviewContent {
    var id: UUID { get }
    func getPreviewData() -> PreviewDataModel?
}
