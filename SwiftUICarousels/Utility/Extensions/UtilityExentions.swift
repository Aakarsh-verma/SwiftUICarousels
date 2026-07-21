//
//  UtilityExentions.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 20/07/26.
//

import Foundation
import Network

extension URLRequest {
    var curlString: String {
        guard let url else {
            return "Invalid URLRequest: URL is missing"
        }

        var components: [String] = ["curl"]

        // HTTP method
        let method = httpMethod ?? "GET"
        components.append("-X \(method)")

        // Headers
        allHTTPHeaderFields?
            .sorted { $0.key < $1.key }
            .forEach { key, value in
                components.append(
                    "-H \(Self.shellEscape("\(key): \(value)"))"
                )
            }

        // Body
        if let httpBody,
           let body = String(data: httpBody, encoding: .utf8),
           !body.isEmpty {
            components.append(
                "--data-raw \(Self.shellEscape(body))"
            )
        }

        // URL
        components.append(Self.shellEscape(url.absoluteString))

        return components.joined(separator: " \\\n  ")
    }

    private static func shellEscape(_ value: String) -> String {
        "'" + value.replacingOccurrences(
            of: "'",
            with: "'\\''"
        ) + "'"
    }
}
