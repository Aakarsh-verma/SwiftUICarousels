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
    
    var body: some View {
        if imageModel.isRemoteImage {
            KFImage(URL(string: imageModel.image)!)
                .placeholder {
                    Image(systemName: "photo.fill")
                        .foregroundColor(.gray)
                }
                .resizable()
        } else if imageModel.isAssetImage {
            Image(imageModel.image)
                .resizable()
        } else {
            Image(systemName: imageModel.image)
                .resizable()
        }
    }
}

#Preview {
    CustomImageView(imageModel: CustomImageModel(for: "photo.fill"))
        .foregroundStyle(.gray)
        .padding()
}
