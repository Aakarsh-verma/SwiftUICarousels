//
//  SearchView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 15/07/25.
//

import SwiftUI

struct SearchView: View {
    @State private var viewModel: SearchViewModelProtocol
    @State private var path = NavigationPath()
    @State private var searchText: String = ""
    @Binding var hideTabBar: Bool 
    
    init(viewModel: SearchViewModelProtocol = SearchViewModel(), 
         hideTabBar: Binding<Bool>) {
        self.viewModel = viewModel
        self._hideTabBar = hideTabBar
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                TopHeaderView(path: $path)
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
            .background(Image(SCImages.spaceBg.rawValue))
            .navigationDestination(for: CardModel.self) { model in
                AnimeDetailView(content: model)
            }
            .navigationDestination(for: String.self) { route in
                withAnimation(.interactiveSpring(response: 0.2, dampingFraction: 0.7, blendDuration: 0.7)) {
                    NavigationHandler.shared.performNavigation(route)
                }
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
    @Previewable @State var overlay = OverlayCoordinator()
    SearchView(hideTabBar: .constant(true))
        .environment(overlay)
}
