//
//  OverlayView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 08/11/25.
//

import SwiftUI

final class OverlayCoordinator: ObservableObject {
    @Published var isPresented: Bool = false
    @Published var content: AnyView? = nil
    @Published var isScreenTapped: Bool = false

    func show<V: View>(_ view: V) {
        content = AnyView(view)
        isPresented = true
    }

    func hide() {
        isPresented = false
        content = nil
        isScreenTapped = false
    }
}
