//
//  AsyncImage.swift
//  MovieApp
//
//  Created by Tolga Sarikaya on 19.07.24.
//

import SwiftUI

struct AsyncImage: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Image
    
    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
           _loader = StateObject(wrappedValue: ImageLoader(url: url))
           self.placeholder = placeholder
       }
    
    var body: some View {
        image
        .onAppear(perform: loader.load)
        }
    
    private var image: some View {
            Group {
                if let image = loader.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    placeholder
                        .resizable()
                        .scaledToFit()
                }
            }
        }
    }
    
