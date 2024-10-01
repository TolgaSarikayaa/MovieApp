//
//  AsyncImage.swift
//  MovieApp
//
//  Created by Tolga Sarikaya on 19.07.24.
//

import SwiftUI


struct AsyncImage: View {
    @StateObject private var loader: ImageLoader
    @State private var blurAmount: CGFloat = 10.0
    
    
    init(url: URL?) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        image
            .cornerRadius(10)
            .blur(radius: blurAmount)
            .onAppear {
                loader.load()
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { timer in
                    if blurAmount > 0 {
                        blurAmount -= 0.7
                    } else {
                        timer.invalidate()
                    }
                }
            }
        
    }
    
    
    private var image: some View {
        Group {
            if let image = loader.image {
                AnyView(Image(uiImage: image)
                    .resizable()
                    .scaledToFit())
            } else {
                AnyView(ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(width: 50, height: 50)) 
            }
        }
    }
}
    
