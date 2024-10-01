//
//  ContentView.swift
//  MovieApp
//
//  Created by Tolga Sarikaya on 18.07.24.
//

import SwiftUI

struct ContentView: View {
    @State private var movies: [Movie] = []
    @State private var currentMovie: Movie?
    @State private var movieOptions: [String] = []
    @StateObject private var service = Service()
    @State private var errorMessage: String?
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var blurAmount: CGFloat = 10.0
    @State private var imageLoaded = false
    
    var body: some View {
        VStack {
            if let currentMovie = currentMovie {
                VStack {
                    AsyncImage(url: URL(string: currentMovie.poster))
                        .frame(width: 400, height: 350)
                        .cornerRadius(8)
                        .shadow(radius: 10)
                        .blur(radius: blurAmount)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 4)) {
                                blurAmount = 0.0
                            }
                            
                        }
                    
                    Text("Welcher Film ist das?")
                        .font(.headline)
                        .padding()
                    VStack {
                        ForEach(movieOptions, id: \.self) { option in
                            Button {
                                checkAnswer(selectedTitle: option)
                            } label: {
                                Text(option)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundStyle(.white)
                                    .cornerRadius(8)
                                    .padding(.bottom, 30)
                            }
                        }
                    }
                }
            } else {
                Text("Loading")
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
            self.currentMovie = nil
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
                        self.currentMovie = randomMovie
                        self.movieOptions = movies.map { $0.title }.shuffled()
                        self.blurAmount = 10.0
                        self.imageLoaded = false
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
        
        private func checkAnswer(selectedTitle: String) {
            if selectedTitle == currentMovie?.title {
                alertMessage = "Richtig!"
            } else {
                alertMessage = "Falsch! Korrekter Film: \(currentMovie?.title ?? "")"
            }
            showAlert = true
        }
    }

#Preview {
    ContentView()
}
