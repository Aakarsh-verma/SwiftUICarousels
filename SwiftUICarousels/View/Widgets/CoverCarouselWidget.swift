//
//  ContentView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 04/05/25.
//

import SwiftUI
import CoreData

struct CoverCarouselWidget: View {
    @State private var activeID: UUID?
    var body: some View {
        CoverCarouselView(config: .init(hasOpacity: true, hasScale: true), data: sampleImages, selection: $activeID) { item in
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}


#Preview {
    CoverCarouselWidget()
        .frame(height: 200)
}
