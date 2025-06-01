//
//  HomeView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 24/05/25.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    @StateObject private var viewModel = HomeViewModel()
    @State private var path = NavigationPath()

    var body: some View {
        VStack {
            TopHeaderView()
            SearchHeaderView(searchText: $searchText, searchForeground: .ultraThick)
                .padding(.horizontal)
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.dashboardWidgets) { widget in
                        HomeWidgetView(item: widget, path: $path)
                    }
                }
                .environmentObject(viewModel)
            }
        }
        .background(.gray.quaternary)
        .frame(maxHeight: .infinity)
        .preferredColorScheme(.dark)
        .task {
            await viewModel.fetchAnimeContent()
        }
    }
}

#Preview {
    HomeView()
}
