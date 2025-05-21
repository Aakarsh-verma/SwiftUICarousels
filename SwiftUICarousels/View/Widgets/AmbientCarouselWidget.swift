//
//  AmbientCarouselWidget.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 17/05/25.
//

import SwiftUI

struct AmbientCarouselWidget: View {
    var body: some View {
        AmbientCarouselView(topInset: .constant(40), scrollOffsetY: .constant(0), images: .constant(sampleImages))
            .padding(40)
    }
}

#Preview {
    AmbientCarouselWidget()
        .preferredColorScheme(.dark)
}
