//
//  GlobalTouchWindowObserver.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 26/10/25.
//

import SwiftUI

struct GlobalTouchWindowObserver: UIViewRepresentable {
    var onTouch: (_ phase: UITouch.Phase, _ location: CGPoint) -> Void

    func makeCoordinator() -> Coordinator { Coordinator(onTouch: onTouch) }

    func makeUIView(context: Context) -> UIView {
        let host = UIView(frame: .zero)
        host.backgroundColor = .clear
        host.isUserInteractionEnabled = false // this view itself does nothing

        DispatchQueue.main.async {
            attachRecognizerIfNeeded(context: context)
        }
        return host
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Ensure recognizer is still attached if window changes (e.g., scene transitions)
        DispatchQueue.main.async {
            attachRecognizerIfNeeded(context: context)
        }
    }

    private func attachRecognizerIfNeeded(context: Context) {
        guard let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }) else { return }

        guard let window = windowScene.windows.first(where: { $0.isKeyWindow }) ?? windowScene.windows.first else { return }

        if context.coordinator.window !== window {
            // If we moved to a new window, remove from old one
            context.coordinator.detach()
            context.coordinator.window = window
        }

        if context.coordinator.recognizer == nil {
            let gr = PassthroughTouchRecognizer()
            gr.cancelsTouchesInView = false
            gr.delaysTouchesBegan = false
            gr.delaysTouchesEnded = false
            gr.onReport = { phase, point in
                onTouch(phase, point)
            }
            window.addGestureRecognizer(gr)
            context.coordinator.recognizer = gr
        }
    }

    class Coordinator {
        var onTouch: (_ phase: UITouch.Phase, _ location: CGPoint) -> Void
        weak var window: UIWindow?
        weak var recognizer: PassthroughTouchRecognizer?
        init(onTouch: @escaping (_ phase: UITouch.Phase, _ location: CGPoint) -> Void) {
            self.onTouch = onTouch
        }
        func detach() {
            if let gr = recognizer, let win = window {
                win.removeGestureRecognizer(gr)
            }
            recognizer = nil
            window = nil
        }
        deinit { detach() }
    }

    /// A UIGestureRecognizer that observes touches and never interferes with other gestures.
    class PassthroughTouchRecognizer: UIGestureRecognizer {
        var onReport: ((_ phase: UITouch.Phase, _ location: CGPoint) -> Void)?

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
            state = .began
            report(touches)
        }
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
            state = .changed
            report(touches)
        }
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
            state = .ended
            report(touches)
        }
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
            state = .cancelled
            report(touches)
        }

        private func report(_ touches: Set<UITouch>) {
            guard let t = touches.first, let view = self.view else { return }
            let p = t.location(in: view)
            onReport?(t.phase, view.convert(p, to: view.window))
        }

        // Do not block or require other gestures
        override func canPrevent(_ preventedGestureRecognizer: UIGestureRecognizer) -> Bool { false }
        override func canBePrevented(by preventingGestureRecognizer: UIGestureRecognizer) -> Bool { false }
        override func shouldRequireFailure(of otherGestureRecognizer: UIGestureRecognizer) -> Bool { false }
        override func shouldBeRequiredToFail(by otherGestureRecognizer: UIGestureRecognizer) -> Bool { false }
    }
}
