//
//  ContentView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 17/05/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HomeViewModel()
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
                        ForEach(viewModel.homeWidgets) { widget in
                            HomeWidgetView(
                                viewType: widget.viewType,
                                title: widget.title,
                                path: $path
                            )
                        }
                    }
                }
                .background(.black.gradient.secondary)
            }
            .navigationDestination(for: String.self) { route in
                withAnimation(.interactiveSpring(response: 0.2, dampingFraction: 0.7, blendDuration: 0.7)) {
                    DeeplinkHandler.shared.performNavigation(route)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
