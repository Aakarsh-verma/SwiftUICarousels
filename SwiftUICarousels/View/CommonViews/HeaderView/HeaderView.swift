//
//  HeaderView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 17/05/25.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        headerView()
    }
    
    @ViewBuilder
    func headerView() -> some View {
        HStack {
            Image(systemName: "xbox.logo")
                .font(.system(size: 35))
            
            VStack(alignment: .leading, spacing: 6) {
                Text("iPhoneUser")
                    .font(.callout)
                    .fontWeight(.semibold)
                
                HStack {
                    Image(systemName: "g.circle.fill")
                    
                    Text("120")
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
