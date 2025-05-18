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
                            Button {
                                path.append("cover")
                            } label: {
                                CoverCarouselWidget()
                                    .frame(height: 220)
                                    .cornerRadius(12)
                                    .padding()
                                    .shadow(radius: 5)
                            }
                            .buttonStyle(ScaledButtonStyle())
                            .padding(.horizontal)
                        }
                        
                        Text("Parallax Carousel")
                            .font(.title.bold())
                            .padding(.horizontal)
                            .padding(.top)
                        
                        VStack(alignment: .leading) {
                            Button {
                                path.append("parallax")
                            } label: {
                                ParallaxCarouselWidget()
                                    .frame(height: 220)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                            }
                            .buttonStyle(ScaledButtonStyle())
                            .clipShape(.rect(cornerRadius: 12))
                            .padding(.horizontal)
                        }
                        
                        Text("Ambient Carousel")
                            .font(.title.bold())
                            .padding(.horizontal)
                            .padding(.top)
                        
                        VStack(alignment: .leading) {
                            Button {
                                path.append("ambient")
                            } label: {
                                AmbientCarouselWidget()
                                    .frame(height: 220)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                            }
                            .buttonStyle(ScaledButtonStyle())
                            .clipShape(.rect(cornerRadius: 12))
                            .padding(.horizontal)
                        }
                    }
                    
                }
                .background(.black.gradient.secondary)
            }
            .navigationDestination(for: String.self) { route in
                withAnimation(.interactiveSpring(response: 0.2, dampingFraction: 0.7, blendDuration: 0.7)) {
                    performNavigation(route)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    fileprivate func performNavigation(_ route: String) -> some View {
        switch route {
        case "cover":
            CoverCarousel()
            
        case "ambient":
            AmbientCarousel()
            
        case "parallax":
            ParallaxCarousel()
            
        default:
            EmptyView()
        }
    }
}

#Preview {
    ContentView()
}
