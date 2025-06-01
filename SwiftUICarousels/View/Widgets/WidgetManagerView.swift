//
//  WidgetManagerView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 01/06/25.
//

import SwiftUI

struct WidgetManagerView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @Binding var path: NavigationPath
    var item: CarouselWidgetModel

    var body: some View {
        switch item.viewType {
        case .cover:
            CoverCarouselWidget()
        case .ambient:
            AmbientCarouselWidget()
        case .parallax:
            ParallaxCarouselWidget()
        case .stack:
            StackCardsWidget()
        }
    }
    
    @ViewBuilder
    private func StackCardsWidget() -> some View {
        switch item.dataType {
        case .imageModel, .none:
            StackCarouselWidget(items: sampleImages) { imageModel in
                CustomImageView(imageModel: CustomImageModel(for: imageModel.image))
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 20))
            }
            
        case .cardModel:
            StackCarouselWidget(items: viewModel.animeCards, height: 400) { model in
                CoverCarouselCardView(content: model, dimensions: .init(width: 240, height: 400))
            } perform: {
                await viewModel.fetchAnimeContent()
            }            
            
        case .tripModel:
            StackCarouselWidget(items: trips) { imageModel in
                CustomImageView(imageModel: CustomImageModel(for: imageModel.image))
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 20))
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var viewModel = HomeViewModel()
    let model = CarouselWidgetModel(title: "Ambient", viewType: .ambient, dataType: .imageModel)

    WidgetManagerView(path: .constant(.init()), item: model)
}
