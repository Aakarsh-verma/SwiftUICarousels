//
//  ParallaxCarousel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 18/05/25.
//

import SwiftUI

struct ParallaxCarousel: View {
    @State private var searchText: String = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                
                SearchHeaderView(searchText: $searchText)
                
                Text("Where do you want to \ntravel?")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                
                ParallaxCarouselView()
            }
            .padding(15)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ParallaxCarousel()
}
