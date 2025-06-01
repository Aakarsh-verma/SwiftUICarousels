//
//  SplashView.swift
//  SwiftUICarousels
//
//  Created by Aakarsh Verma on 18/05/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        Group {
            if isActive {
                CustomTabView()
            } else {
                ZStack {
                    Rectangle()
                        .fill(.black)
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        VStack {
                            HStack {
                                Image(systemName: "swift")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(.orange.mix(with: .red, by: 0.5))
                                
                                Text("Welcome")
                                    .font(.largeTitle.bold())
                                    .padding(.top)
                            }
                            
                            Text("Carousels App")
                                .font(.title.bold())
                                .foregroundStyle(.white.mix(with: .black, by: 0.15))
                        }
                        .padding()
                        .padding(.bottom, 24)
                        .padding(.leading, 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay {
                            LinearGradient(colors: [
                                .clear,
                                .clear,
                                .black.opacity(0.3),
                                .black.opacity(0.5),
                                .black.opacity(0.7)
                            ], startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .preferredColorScheme(.dark)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
