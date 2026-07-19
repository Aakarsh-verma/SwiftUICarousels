//
//  NumberExtension.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 28/05/25.
//

import Foundation

extension Int? {
    func toString() -> String {
        guard let self = self else { return "" }
        return String(self)
    }
}

extension Int {
    func formatCount() -> String {
        let num = Double(self)
        let thousand = num / 1_000
        let million = num / 1_000_000
        let billion = num / 1_000_000_000

        let formatter: (Double, String) -> String = { value, suffix in
            let formatted = String(format: value >= 10 ? "%.0f" : "%.1f", value)
            return formatted.hasSuffix(".0") ? "\(Int(value))\(suffix)" : "\(formatted)\(suffix)"
        }

        switch self {
        case 1_000_000_000...:
            return formatter(billion, "B")
        case 1_000_000...:
            return formatter(million, "M")
        case 1_000...:
            return formatter(thousand, "k")
        default:
            return "\(self)"
        }
    }
}
