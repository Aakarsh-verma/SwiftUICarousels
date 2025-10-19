//
//  CustomImageView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 20/05/25.
//

import SwiftUI
import Kingfisher

struct CustomImageView: View {
    var imageModel: CustomImageModel
    var zoomable: Bool = false
    
    init(_ imageModel: CustomImageModel, zooms: Bool = false) {
        self.imageModel = imageModel
        self.zoomable = zooms
    }
    
    var body: some View {
        if imageModel.isRemoteImage {
            KFImage(URL(string: imageModel.image)!)
                .placeholder {
                    Image(systemName: "photo.fill")
                        .foregroundColor(.gray)
                }
                .resizable()
                .applyIf(zoomable, modifier: { view in
                    view
                        .pinchZoom()
                })
        } else if imageModel.isAssetImage {
            Image(imageModel.image)
                .resizable()
        } else {
            Image(systemName: imageModel.image)
                .resizable()
        }
    }
}

struct FallingCardsView: View {
    @State private var offsets: [CGPoint] = [
        .init(x: 0, y: -500),
        .init(x: 0, y: -500),
        .init(x: 0, y: -500),
    ]
    @State private var collapsed = false
    @State private var rotationAngles: [Double] = [0, 0, 0]
    
    var body: some View {
        GeometryReader { geometry in
            let safeAreaInsets = geometry.safeAreaInsets.top
            VStack(spacing: 0) {
                
                ForEach(0..<3) { index in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue)
                        .frame(width: 300, height: 100, alignment: .center)
                        .offset(x: offsets[index].x, y: offsets[index].y)
                        .rotationEffect(.degrees(rotationAngles[index]), anchor: .bottom)
                        .animation(.interpolatingSpring(stiffness: 120, damping: 14), value: offsets[index])
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    // Move the dragged card and all those above
                                    let dragX = value.location.x - geometry.size.width / 2
                                    for i in 0...index {
                                        if (i != index && value.translation.height <= -10) || i == index { 
                                            offsets[i] = CGPoint(x: value.translation.width, 
                                                                 y: value.translation.height - CGFloat(i * 10))
                                            rotationAngles[i] = -Double(dragX / 20) // smaller divisor means more tilt sensitivity

                                        } else {
                                            rotationAngles[i] = 0.0
                                            offsets[i] = .init(x: 0, y: i * 10)
                                        }
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.spring(response: 0.7, dampingFraction: 0.6)) { 
                                        rotationAngles = Array(repeating: 0.0, count: 3)
                                        offsets = [
                                            .init(x: 0, y: 0),
                                            .init(x: 0, y: 10),
                                            .init(x: 0, y: 20),
                                        ]
                                    }
                                }
                        )
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.8)) {
                offsets = [
                    .init(x: 0, y: 0),
                    .init(x: 0, y: 10),
                    .init(x: 0, y: 20),
                ]
            }
        }
    }
}


#Preview {
    FallingCardsView()
}
