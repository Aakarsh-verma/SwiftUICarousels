//
//  HomeWidgetView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 18/05/25.
//

import SwiftUI

struct HomeWidgetView: View {
    var viewType: CarouselViewType
    var title: String
    @Binding var path: NavigationPath
    
    var body: some View {
        Text(title)
            .font(.title.bold())
            .padding(.horizontal)
            .padding(.top)
        
        VStack(alignment: .leading) {
            Button {
                path.append(viewType.rawValue)
            } label: {
                viewType.widgetView()
                    .frame(height: 220)
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
    HomeWidgetView(viewType: .ambient, title: "Ambient", path: .constant(.init()))
}
