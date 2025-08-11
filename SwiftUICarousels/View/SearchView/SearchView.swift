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
                    searchForeground: .ultraThick,
                    submitAction: {
                        Task(priority: .userInitiated) { 
                            await viewModel.fetchSearchAnimeContent(for: searchText)
                        }  
                    }
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
    SearchView(hideTabBar: .constant(true))
}
