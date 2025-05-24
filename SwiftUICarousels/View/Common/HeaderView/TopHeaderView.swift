//
//  TopHeaderView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 24/05/25.
//

import SwiftUI

struct TopHeaderView: View {
    let title: String = "Hello, "
    let subtitle: String = "Welcome to AniBrowser!"
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(self.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                HStack {
                    Text(subtitle)
                        .font(.callout)
                }
            }
            
            Spacer()
            
            Image(systemName: "person.circle.fill")
                .font(.largeTitle)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal)
    }
}

#Preview {
    TopHeaderView()
}
