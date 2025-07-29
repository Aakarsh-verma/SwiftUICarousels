//
//  FilterTab.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/07/25.
//

import SwiftUI

enum BorderType {
    case rect
    case roundRect(radius: CGFloat)
    case capsule
    case circle
    case none
    
    var shape: AnyShape {
        switch self {
        case .rect:
            return AnyShape(Rectangle())
        case .roundRect(let radius):
            return AnyShape(RoundedRectangle(cornerRadius: radius))
        case .capsule:
            return AnyShape(Capsule(style: .continuous))
        case .circle:
            return AnyShape(Circle())
        case .none:
            return AnyShape(EmptyShape()) 
        }
    }
}

struct EmptyShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path()
    }
}

struct FilterTabsModel: Identifiable {
    let id = UUID()
    var item: FilterItemModel = FilterItemModel()
}

struct FilterItemModel: Identifiable {
    let id = UUID()
    let text: String
    let leftImage: String
    let color: Color
    let borderColor: Color
    let borderType: BorderType
    let type: FilterType
    
    init(text: String = "Filter",
         leftImage: String = "heart.fill",
         color: Color = .black,
         borderColor: Color = .black,
         borderType: BorderType = .capsule,
         type: FilterType = .status) {
        self.text = text
        self.leftImage = leftImage
        self.color = color
        self.borderColor = borderColor
        self.borderType = borderType
        self.type = type
    }
}

enum FilterType {
    case status
    case sortOrder
}

struct FilterTab: View {
    var model: FilterTabsModel
    var delegate: FilterTabProtocol?
    @State private var isSelected: Bool = false
    init(item model: FilterTabsModel = FilterTabsModel(), _ delegate: FilterTabProtocol? = nil) {
        self.model = model
        self.delegate = delegate
    }
    
    var body: some View {
        HStack(spacing: 12) {
            HStack {
                Image(systemName: isSelected ? "xmark" : model.item.leftImage)
                
                Text(model.item.text)                    
            }
            .padding()
            .background(isSelected ? model.item.color : .clear)
            .foregroundColor(isSelected ? .black : model.item.color)
            .clipShape(model.item.borderType.shape)
            .onTapGesture {
                delegate?.filterTapped(type: model.item.type)
                isSelected.toggle()
            }
        }
    }
}

#Preview {
    FilterTab()
}
