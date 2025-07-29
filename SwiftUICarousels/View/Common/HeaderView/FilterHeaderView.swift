//
//  FilterHeaderView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 21/07/25.
//

import SwiftUI

protocol FilterTabProtocol {
    func filterTapped(type: FilterType)
}

struct FilterHeaderView: View, FilterTabProtocol {
    @Binding var filterItems: [FilterTabsModel]
    
    private let isScrollEnabled: Bool
    private var action: ((FilterType) -> ())?
    
    
    init(isScrollEnabled: Bool = false, filters filterItems: Binding<[FilterTabsModel]>, action: ((FilterType) -> ())? = nil) {
        self.isScrollEnabled = isScrollEnabled
        self._filterItems = filterItems
        self.action = action
    }
    
    var body: some View {
        VStack { 
            if isScrollEnabled {
                ScrollView(.horizontal, showsIndicators: false) { 
                    HStack {
                        ForEach(filterItems) { item in
                            FilterTab(item: item)
                        }
                    }
                }
                .scrollBounceBehavior(.basedOnSize)
            } else {
                HStack {
                    ForEach(filterItems) { item in
                        FilterTab(item: item)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func filterTapped(type: FilterType) {
        action?(type)
    }
}

#Preview {
    let filters = Array(repeating: FilterTabsModel(), count: 2)
    FilterHeaderView(filters: .constant(filters))
}
