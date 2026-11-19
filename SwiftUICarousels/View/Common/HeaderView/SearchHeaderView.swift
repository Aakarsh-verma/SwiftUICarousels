//
//  SearchHeaderView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 18/05/25.
//

import SwiftUI

struct SearchHeaderView: View {
    @Binding var searchText: String
    var submitAction: ActionCallback? = nil
    
    var body: some View {
        searchHeaderView()
    }
    
    @ViewBuilder
    func searchHeaderView() -> some View {
        HStack(spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: SCImages.search.rawValue)
                    .foregroundStyle(.gray)
                
                TextField("Search", text: $searchText)
                    .onSubmit {
                        submitAction?()
                    }
                
                Button {
                    //
                } label: {
                    Image(systemName: SCImages.filter.rawValue)
                        .font(.title2)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .glassBackground(.capsule)
        }
        
    }
}

#Preview {
    SearchHeaderView(searchText: .constant(""))
}
