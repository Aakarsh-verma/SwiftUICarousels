//
//  PinchZoomHelper.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 19/10/25.
//

import SwiftUI

struct PinchZoomHelper<Content: View>: View {
    @ViewBuilder var content: Content
    @State private var config: ZoomConfig = .init()
    @State private var zoom: CGFloat = 1
    @State private var anchor: UnitPoint = .center
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        content
            .scaleEffect(zoom, anchor: anchor)
            .offset(dragOffset)
            .overlay(GestureOverlay(config: $config))
            .overlay {
                Color.clear
                    .onChange(of: config.isActive) { oldValue, newValue in
                        handleGestureStateChange(newValue)
                    }
                    .onChange(of: config) { oldValue, newValue in
                        handleZoomingAndPanning()
                    }
            }
    }
    
    fileprivate func handleGestureStateChange(_ isActive: Bool) {
        if isActive {
            anchor = config.anchor
        } else {
            resetZoomState()
        }
    }
    
    fileprivate func resetZoomState() {
        withAnimation(.snappy(duration: 0.2, extraBounce: 0), completionCriteria: .logicallyComplete) { 
            dragOffset = .zero
            zoom = 1
        } completion: { 
            config = .init()
        }
    }
    
    fileprivate func handleZoomingAndPanning() {
        guard config.isActive else { return }
        let isScaleChanged = abs(zoom - config.zoom) > 0.01
        let isPanChangedX = abs(dragOffset.width - config.dragOffset.width) > 5.0
        let isPanChangedY = abs(dragOffset.height - config.dragOffset.height) > 5.0
        let isPanChanged = isPanChangedX || isPanChangedY
        
        if isScaleChanged { zoom = config.zoom }
        if isPanChanged { dragOffset = config.dragOffset }
    }
}

fileprivate struct ZoomConfig: Equatable {
    var isActive: Bool = false
    var zoom: CGFloat = 1
    var anchor: UnitPoint = .center
    var dragOffset: CGSize = .zero
}

fileprivate struct GestureOverlay: UIViewRepresentable {
    @Binding var config: ZoomConfig
    
    func makeCoordinator() -> Coordnator {
        Coordnator(config: $config)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let panGesture = UIPanGestureRecognizer()
        panGesture.name = "PINCHPANGESTURE"
        panGesture.minimumNumberOfTouches = 2
        panGesture.addTarget(context.coordinator, action: #selector(Coordnator.handlePanGesture(_:)))
        panGesture.delegate = context.coordinator
        view.addGestureRecognizer(panGesture)
        let pinchGesture = UIPinchGestureRecognizer()
        pinchGesture.name = "PINCHZOOMGESTURE"
        pinchGesture.addTarget(context.coordinator, action: #selector(Coordnator.handlePinchGesture(_:)))
        pinchGesture.delegate = context.coordinator
        view.addGestureRecognizer(pinchGesture)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    class Coordnator: NSObject, UIGestureRecognizerDelegate {
        @Binding var config: ZoomConfig
        
        init(config: Binding<ZoomConfig>) {
            _config = config
        }
        
        @objc
        func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
            if gesture.state == .began || gesture.state == .changed {
                let translation = gesture.translation(in: gesture.view)
                config.dragOffset = .init(width: translation.x, height: translation.y)
                config.isActive = true
            } else {
                config.isActive = false
            }
        }
        
        @objc
        func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
            if gesture.state == .began {
                let location = gesture.location(in: gesture.view)
                if let bounds = gesture.view?.bounds {
                    config.anchor = .init(x: location.x / bounds.width, y: location.y / bounds.height)
                }
            }
            if gesture.state == .began || gesture.state == .changed {
                let scale = max(1, gesture.scale)
                config.zoom = scale
                config.isActive = true
            } else {
                config.isActive = false
            }
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            if gestureRecognizer.name == "PINCHPANGESTURE" && otherGestureRecognizer.name == "PINCHZOOMGESTURE" {
                return true
            }
            return false
        }
    }
}
