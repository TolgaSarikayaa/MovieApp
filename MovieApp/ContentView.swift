//
//  ContentView.swift
//  MovieApp
//
//  Created by Tolga Sarikaya on 18.07.24.
//

import SwiftUI

struct ContentView: View {
    @State private var movies: [Movie] = []
    @State private var currentMovieTitle: String = ""
    @StateObject private var service = Service()
    @State private var errorMessage: String?
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            if !currentMovieTitle.isEmpty {
                Text("Welcher Film ist das: \(currentMovieTitle)?")
                    .font(.headline)
                    .padding()
            }
            
            if movies.count == 2 {
                HStack {
                    ForEach(movies) { movie in
                        VStack {
                            AsyncImage(url: URL(string: movie.poster))
                                    .frame(width: 150, height: 200)
                                    .onTapGesture {
                                        checkAnswer(movie: movie)
                            }
                        }
                    }
                }
            } else {
                Text("Loading...")
            }
            
        }
        .padding()
        .onAppear {
            loadMovies()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Ergebniss"), message: Text(alertMessage), dismissButton: .default(Text("Okey"), action: {
                if self.alertMessage == "Richtig!" {
                    self.loadMovies()
                }
            }))
        }
    }
        
        private func loadMovies() {
            self.currentMovieTitle = ""
            self.movies = []
            
            let allFilmTitles = [
                        "Blade Runner", "Inception", "The Matrix", "The Godfather", "Pulp Fiction",
                        "The Dark Knight", "Fight Club", "Forrest Gump", "The Shawshank Redemption",
                        "Interstellar", "Gladiator", "The Silence of the Lambs", "Se7en", "The Prestige",
                        "Memento", "Titanic", "The Departed", "Goodfellas", "Braveheart", "Jaws"
                    ]
            let selectedTitles = Array(allFilmTitles.shuffled().prefix(2))
           
            service.fetchData(titles: selectedTitles) { result in
                switch result {
                case .success(let movies):
                    self.movies = movies
                    if let randomMovie = movies.randomElement() {
                        self.currentMovieTitle = randomMovie.title
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
        
        private func checkAnswer(movie: Movie) {
            if movie.title == currentMovieTitle {
                alertMessage = "Richtig!"
            } else {
                alertMessage = "Falsch! Korrekter Film: \(currentMovieTitle)"
            }
            showAlert = true
        }
    }

#Preview {
    ContentView()
}
