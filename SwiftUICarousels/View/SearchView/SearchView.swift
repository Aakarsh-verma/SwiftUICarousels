//
//  SearchView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 15/07/25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @StateObject private var viewModel = SearchViewModel()
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TopHeaderView()
                SearchHeaderView(
                    searchText: $searchText,
                    searchForeground: .ultraThick,
                    submitAction: {
                        Task(priority: .userInitiated) { 
                            await viewModel.fetchSearchAnimeContent(for: searchText)
                        }  
                    }
                )

                ScrollView(showsIndicators: false) {
                    CustomGridView(
                        items: $viewModel.animeCards
                    ) { model in
                        GridCard(path: $path, content: model)
                    }

                }
            }
            .padding(.horizontal)
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
    SearchView()
}
