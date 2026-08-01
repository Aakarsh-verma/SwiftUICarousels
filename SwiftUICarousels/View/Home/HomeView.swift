//
//  HomeView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 24/05/25.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    @State private var viewModel = HomeViewModel()
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TopHeaderView()
                    .padding(.horizontal)
                
                SearchHeaderView(searchText: $searchText)
                    .padding(.horizontal)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.dashboardWidgets) { widget in
                            HomeWidgetView(viewModel: $viewModel, 
                                           item: widget, path: $path)
                        }
                    }
                }
            }
            .background(.gray.quaternary)
            .frame(maxHeight: .infinity)
            .preferredColorScheme(.dark)
            .navigationDestination(for: CardModel.self) { model in
                AnimeDetailView(content: model)
            }
        }
        .task {
            await viewModel.fetchAnimeContent()
        }
    }
}

#Preview {
    HomeView()
}
