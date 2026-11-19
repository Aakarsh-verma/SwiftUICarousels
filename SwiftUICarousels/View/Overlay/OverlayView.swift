//
//  OverlayView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 08/11/25.
//

import SwiftUI

@Observable
final class OverlayCoordinator {
    var isPresented: Bool = false
    var content: AnyView? = nil
    var isScreenTapped: Bool = false

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
