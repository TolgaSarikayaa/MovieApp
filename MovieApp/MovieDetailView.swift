//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Tolga Sarikaya on 19.07.24.
//

import SwiftUI

struct MovieDetailView: View {
    var movie: Movie
        @State private var image: UIImage? = nil

        var body: some View {
            VStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .onAppear {
                            loadImage()
                        }
                }
                Text(movie.title)
                    .font(.largeTitle)
                    .padding()
                Text(movie.year)
                    .font(.title2)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding()
            .navigationTitle(movie.title)
        }

        private func loadImage() {
            guard let url = URL(string: movie.poster) else {
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
