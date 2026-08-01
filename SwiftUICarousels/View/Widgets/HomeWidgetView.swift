//
//  HomeWidgetView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 18/05/25.
//

import SwiftUI

struct HomeWidgetView: View {
    @Binding var viewModel: HomeViewModel
    var item: CarouselWidgetModel
    @Binding var path: NavigationPath
    
    var body: some View {
        Text(item.title)
            .font(.title.bold())
            .padding(.horizontal)
            .padding(.top)
        
        VStack(alignment: .leading) {
            Button {
                path.append(item.viewType.rawValue)
            } label: {
                WidgetManagerView(viewModel: $viewModel, 
                                  path: $path, item: item)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            }
            .buttonStyle(ScaledButtonStyle())
            .clipShape(.rect(cornerRadius: 12))
            .padding(.horizontal)
        }
    }
}

#Preview {
    let model = CarouselWidgetModel(title: "Ambient", viewType: .ambient, dataType: .imageModel)
    
    HomeWidgetView(viewModel: .constant(.init()), item: model, path: .constant(.init()))
}
