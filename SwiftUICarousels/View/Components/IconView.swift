//
//  IconView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 12/07/25.
//

import SwiftUI

struct IconView: View {
    let model: IconModel
    private let frameLength: CGFloat
    @State private var interaction: Bool = false
    @Binding var isFill: Bool
    
    public init(with model: IconModel, isFilled: Binding<Bool> = .constant(false)) {
        self.model = model
        let additionalPadding: CGFloat = (model.type == .tertiary) ? 0 : 24 
        frameLength = model.size.rawValue + additionalPadding
        _isFill = isFilled
    }
    
    var body: some View {
        Circle()
            .fill(model.bgColor)
            .applyIf(model.type != .tertiary, modifier: { 
                $0.stroke(model.color.secondary, style: .init(lineWidth: 2))
            })
            .frame(width: frameLength, height: frameLength)
            .overlay {
                Image(systemName: isFill ? model.name + ".fill" : model.name)
                    .font(.system(size: model.size.rawValue, weight: .semibold))
                    .applyIfLet(model.style, modifier: { view, style in
                        view.foregroundStyle(model.color, style)
                    }, else: { view in
                        view.foregroundStyle(model.color)
                    })
            }
            .radialTapGesture {
                interaction.toggle()
                model.tapAction?()
            }
            .symbolEffect(.bounce.byLayer.down, value: interaction)
    }
}

#Preview {
    @Previewable @State var status = false
    let model = IconModel(
        name: "heart",
        type: .primary,
        size: .Regular,
        color: .black,
        bgColor: .white,
        tapAction: {
            status.toggle()
        })
    
    IconView(with: model,
             isFilled: $status)
}
