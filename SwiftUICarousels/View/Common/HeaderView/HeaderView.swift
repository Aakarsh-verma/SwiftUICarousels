//
//  HeaderView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 17/05/25.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    
    init(title: String = "iPhoneUser", subtitle: String = "") {
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        headerView()
    }
    
    @ViewBuilder
    func headerView() -> some View {
        HStack {
            IconView(with: .init(name: "apple.meditate.circle.fill", type: .tertiary, size: .XLarge, color: .black, style: AnyShapeStyle(.white)))
            
            VStack(alignment: .leading, spacing: 6) {
                Text(self.title)
                    .font(.callout)
                    .fontWeight(.semibold)
                
                HStack {
                    Image(systemName: "y.circle.fill")
                    
                    Text(subtitle)
                        .font(.caption)
                }
            }
            
            Spacer(minLength: 0)
            
            IconView(with: .init(name: "square.and.arrow.up.circle.fill", type: .tertiary, size: .XLarge, color: .white, style: AnyShapeStyle(.fill)))
            
            IconView(with: .init(name: "bell.circle.fill", type: .tertiary, size: .XLarge, color: .white, style: AnyShapeStyle(.fill)))
        }
        .padding(.bottom)
    }
}

#Preview {
    HeaderView()
        .preferredColorScheme(.dark)
}
