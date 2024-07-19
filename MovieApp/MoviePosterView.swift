//
//  MoviePosterView.swift
//  MovieApp
//
//  Created by Tolga Sarikaya on 19.07.24.
//

import SwiftUI

struct MoviePosterView: View {
    let posterURL: String
    @State private var image: UIImage? = nil

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else {
            ProgressView()
                .onAppear {
                    loadImage()
                }
        }
    }

    private func loadImage() {
        guard let url = URL(string: posterURL) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            }
        }
        task.resume()
    }
}
