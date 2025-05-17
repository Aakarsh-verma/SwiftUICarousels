//
//  ContentView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 17/05/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            
            Text("Carousels")
                .font(.largeTitle.bold())
                .padding(.horizontal)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Cover Carousel")
                        .font(.title.bold())
                        .padding(.horizontal)
                    
                    NavigationLink(destination: CoverCarousel()) {
                        CoverCarouselWidget()
                            .frame(height: 220)
                            .cornerRadius(12)
                            .padding()
                            .shadow(radius: 5)
                    }
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 12))
                    .padding(.horizontal)
                }
                
            }
            .background(.gray.tertiary)
        }
    }
}

#Preview {
    ContentView()
}
