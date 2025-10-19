//
//  CoverCarousel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 17/05/25.
//

import SwiftUI


struct CoverCarousel: View {
    @State private var activeID: UUID?
    @StateObject var viewModel = HomeViewModel(contentType: .season((year: "2020", season: .winter)))

    var body: some View {
        VStack {
            HeaderView()
                .padding(.horizontal)
            
            CoverCarouselView(config: .init(hasOpacity: true, hasScale: true), data: viewModel.animeImages, selection: $activeID) { item in
                CustomImageView(CustomImageModel(for: item.image))
                    .aspectRatio(contentMode: .fill)
            }
            .frame(height: 240)
            .padding(.vertical)
            
            Spacer()
        }
        .navigationTitle("Cover Carousel")
        .preferredColorScheme(.dark)
        .task {
            await viewModel.fetchAnimeContent()
        }
    }
}

#Preview {
    CoverCarousel().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
