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
            VStack(spacing: 0) {
                
                HStack {
                    Text("SwiftUI Carousels")
                        .font(.largeTitle.bold())
                        .padding(.bottom)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                ScrollView {
                    VStack(alignment: .leading) {
                        
                        Text("Cover Carousel")
                            .font(.title.bold())
                            .padding(.horizontal)
                            .padding(.top)
                        
                        NavigationLink(destination: CoverCarousel()) {
                            CoverCarouselWidget()
                                .frame(height: 220)
                                .cornerRadius(12)
                                .padding()
                                .shadow(radius: 5)
                        }
                        .clipShape(.rect(cornerRadius: 12))
                        .padding(.horizontal)
                        
                        Text("Ambient Carousel")
                            .font(.title.bold())
                            .padding(.horizontal)
                            .padding(.top)
                        
                        NavigationLink(destination: AmbientCarousel()) {
                            AmbientCarouselWidget()                                .frame(height: 220)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                        .clipShape(.rect(cornerRadius: 12))
                        .padding(.horizontal)
                    }
                    
                }
                .background(.black.gradient)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
