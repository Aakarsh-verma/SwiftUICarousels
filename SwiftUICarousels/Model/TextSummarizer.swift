//
//  TextSummarizer.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 08/11/25.
//

import Foundation
import FoundationModels

class TextSummarizer {
    func summarize(_ text: String) async throws -> String {
        if #available(iOS 26.0, *) {
            return try await aiSummarize(text)
        } else {
            return truncateContent(text)
        }
    }
    
    @available(iOS 26.0, *)
    func aiSummarize(_ text: String) async throws -> String  {
        let model = SystemLanguageModel.default
        guard model.availability == .available else { 
            throw NSError(domain: "ModelUnavailable", code: 0, userInfo: nil) 
        }
        let session = LanguageModelSession(model: model)
        let prompt = "Summarize the following text in less than 50 words:\n\n\(text)"
        let response = try await session.respond(to: prompt, options: .init(maximumResponseTokens: 100))
        return response.content
    }
    
    func truncateContent(_ text: String) -> String {
        return String(text.prefix(200)) + "..."
    }
}
