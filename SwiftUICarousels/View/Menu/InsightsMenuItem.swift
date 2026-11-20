//
//  InsightsMenuItem.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 20/11/26.
//

import SwiftUI

// MARK: - Activity Insights
struct InsightsMenuItem: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 8) {
                Image(systemName: "chart.bar.yaxis")
                    .foregroundStyle(.secondary)

                Text("Your Metrics")
                    .font(.system(size: 17, weight: .bold))

                Spacer()

                Text("Novice")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.green)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(
                        .green.opacity(0.10),
                        in: Capsule()
                    )
            }

            divider

            HStack {
                metric("35", title: "Favorites")
                metric("45.1K", title: "Ongoing")
                metric("40.1K", title: "Watched")
            }
        }
        .padding(20)
        .clayCard(radius: 30)
    }
    
    private var divider: some View {
        Rectangle()
            .fill(.primary.opacity(0.09))
            .frame(height: 1)
    }

    private func metric(_ value: String, title: String) -> some View {
        VStack(spacing: 5) {
            Text(value)
                .font(.system(size: 18, weight: .semibold))

            Text(title)
                .font(.system(size: 14))
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    InsightsMenuItem()
}
