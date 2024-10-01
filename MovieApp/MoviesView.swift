//
//  MoviesView.swift
//  MovieApp
//
//  Created by Tolga Sarikaya on 19.07.24.
//

import SwiftUI

struct MoviesView: View {
    @StateObject private var service = Service()
    @State private var searchMovie = ""
    @State private var errorMessage: String? = nil

    var body: some View {
        NavigationStack {
            VStack {
                if searchMovie.isEmpty {
                    Text("Please enter a movie name to search.")
                        .padding()
                } else {
                    List(service.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            HStack {
                                MoviePosterView(posterURL: movie.poster)
                                    .frame(width: 50, height: 75)
                                VStack(alignment: .leading) {
                                    Text(movie.title)
                                        .font(.headline)
                                    Text(movie.year)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Search Movie")
            .searchable(text: $searchMovie)
            .onChange(of: searchMovie) { newValue , oldValue in
                if !newValue.isEmpty {
                    let titles = [newValue] 
                    service.fetchData(titles: titles) { result in
                        switch result {
                        case .success(let movies):
                            DispatchQueue.main.async {
                                self.service.movies = movies
                                self.errorMessage = nil
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.errorMessage = error.localizedDescription
                                self.service.movies = []
                            }
                        }
                    }
                } else {
                    self.service.movies = []
                }
            }
        }
    }
}
