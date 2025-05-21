//
//  CoverCarousel.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 17/05/25.
//

import SwiftUI


struct CoverCarousel: View {
    @State private var activeID: UUID?

    var body: some View {
        VStack {
            HeaderView()
                .padding(.horizontal)
            
            CoverCarouselView(config: .init(hasOpacity: true, hasScale: true), data: sampleImages, selection: $activeID) { item in
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(height: 240)
            .padding(.vertical)
            
            Spacer()
        }
        .navigationTitle("Cover Carousel")
        .preferredColorScheme(.dark)
    }
}

#Preview {
    CoverCarousel().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
