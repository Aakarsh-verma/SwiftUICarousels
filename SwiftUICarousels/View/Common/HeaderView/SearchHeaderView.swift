//
//  SearchHeaderView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 18/05/25.
//

import SwiftUI

struct SearchHeaderView: View {
    @Binding var searchText: String
    var searchForeground: Material = .ultraThinMaterial
    var submitAction: ActionCallback? = nil
    
    var body: some View {
        searchHeaderView()
    }
    
    @ViewBuilder
    func searchHeaderView() -> some View {
        HStack(spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                
                TextField("Search", text: $searchText)
                    .onSubmit {
                        submitAction?()
                    }
                
                Button {
                    //
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.title2)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(searchForeground, in: .capsule)
        }
        
    }
}

#Preview {
    SearchHeaderView(searchText: .constant(""))
}
