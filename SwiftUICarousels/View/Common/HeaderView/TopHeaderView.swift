//
//  TopHeaderView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 24/05/25.
//

import SwiftUI

struct TopHeaderView: View {
    let title: String = "Hello, "
    var subtitle: String
    @Binding var path: NavigationPath
    
    init(subtitle: String = "Welcome to AniBrowser!", 
         path: Binding<NavigationPath> = .constant(.init())) {
        self.subtitle = subtitle
        self._path = path
    }
    
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
            
            Image(systemName: SCImages.account.rawValue)
                .font(.largeTitle)
                .foregroundStyle(.gray)
                .onTapGesture {
                    path.append("menu")
                }
        }
    }
}

#Preview {
    TopHeaderView()
}
