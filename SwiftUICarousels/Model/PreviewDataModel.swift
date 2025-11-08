//
//  PreviewDataModel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 26/10/25.
//

import Foundation

protocol CardPreviewContent {
    var id: UUID { get }
    func getPreviewData() -> PreviewDataModel?
}

struct PreviewDataModel {
    var image: CustomImageModel?
    var title: String?
    var description: String?
}

extension PreviewDataModel {
    func getShortDescription() async -> String {
        let summarizer = TextSummarizer()
        guard let description else { return "" }
        do {
            return try await summarizer.summarize(description)
        } catch {
            return summarizer.truncateContent(description)
        }
    }
}
