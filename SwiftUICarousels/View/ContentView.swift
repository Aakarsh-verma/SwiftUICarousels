//
//  ContentView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 04/05/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var activeID: UUID?

    var body: some View {
        NavigationView {
            VStack {
                CustomCarouselView(config: .init(hasOpacity: true, hasScale: true), data: images, selection: $activeID) { item in
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(height: 240)
                .padding(.vertical)
                
                Spacer()
            }
            .navigationTitle("Cover Carousel")
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
