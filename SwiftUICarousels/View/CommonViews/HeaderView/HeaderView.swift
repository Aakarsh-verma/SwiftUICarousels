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
            Image(systemName: "apple.meditate.circle.fill")
                .font(.system(size: 35))
            
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
            
            Image(systemName: "square.and.arrow.up.circle.fill")
                .font(.largeTitle)
                .foregroundStyle(.white, .fill)
            
            Image(systemName: "bell.circle.fill")
                .font(.largeTitle)
                .foregroundStyle(.white, .fill)
        }
        .padding(.bottom)
    }
}

#Preview {
    HeaderView()
}
