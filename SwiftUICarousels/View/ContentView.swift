//
//  ContentView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 17/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
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
                        
                        VStack(alignment: .leading) {
                            TapEffectView {
                                path.append("cover")
                            } content: {
                                CoverCarouselWidget()
                                    .frame(height: 220)
                                    .cornerRadius(12)
                                    .padding()
                                    .shadow(radius: 5)
                            }
                            .clipShape(.rect(cornerRadius: 12))
                            .padding(.horizontal)
                        }
                        
                        Text("Ambient Carousel")
                            .font(.title.bold())
                            .padding(.horizontal)
                            .padding(.top)
                        
                        VStack(alignment: .leading) {
                            TapEffectView {
                                path.append("ambient")
                            } content: {
                                AmbientCarouselWidget()
                                    .frame(height: 220)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                            }
                            .clipShape(.rect(cornerRadius: 12))
                            .padding(.horizontal)
                        }
                    }
                    
                }
                .background(.black.gradient)
            }
            .navigationDestination(for: String.self) { route in
                switch route {
                case "cover":
                    CoverCarousel()
                    
                case "ambient":
                    AmbientCarousel()
                    
                default:
                    EmptyView()
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
