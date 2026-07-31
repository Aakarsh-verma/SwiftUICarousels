//
//  SearchView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 15/07/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var path = NavigationPath()
    @State private var searchText: String = ""
    @Binding var hideTabBar: Bool 

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TopHeaderView()
                SearchHeaderView(
                    searchText: $searchText,
                    submitAction: searchAction
                )
                
                FilterHeaderView(filters: $viewModel.filters) { type in
                    print(type)
                }

                ScrollView(showsIndicators: false) {
                    CustomGridView(
                        items: $viewModel.animeCards
                    ) { model in
                        GridCard(path: $path, content: model)
                    }
                    paginationView
                }
                .onScrollPhaseChange { oldPhase, newPhase in
                    switch newPhase {
                    case .idle:
                        withAnimation { 
                            hideTabBar = false
                        }
                    case .decelerating:
                        withAnimation { 
                            hideTabBar = true
                        }
                    default: break
                    }
                }
            }
            .padding(.horizontal)
            .frame(maxHeight: .infinity)
            .preferredColorScheme(.dark)
            .navigationDestination(for: CardModel.self) { model in
                AnimeDetailView(content: model)
            }
        }
        .task {
            await viewModel.fetchInitialPage()
        }
    }

    private var paginationView: some View {
        Color.clear
            .frame(height: 24)
            .overlay {
                if viewModel.isLoadingNextPage {
                    ProgressView()
                        .padding(.vertical, 24)
                }
            }
            .onScrollVisibilityChange(threshold: 0.5) { isVisible in
                guard isVisible else { return }

                Task(priority: .userInitiated) {
                    await viewModel.fetchMoreContent()
                }
            }
    }

    private func searchAction() {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return }
        
        Task(priority: .userInitiated) {
            await viewModel.fetchSearchAnimeContent(for: query)
        }
    }
}

#Preview {
    SearchView(hideTabBar: .constant(true))
}
