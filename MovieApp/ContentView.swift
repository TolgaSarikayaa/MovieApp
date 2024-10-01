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
    @State private var selectedGenre: String = "action"
    let genres = ["action", "drama", "comedy", "thriller"]
//    @State private var blurAmount: CGFloat = 10.0
    
    var body: some View {
        VStack {
            Picker("Select Genre", selection: $selectedGenre) {
                ForEach(genres, id: \.self) { genre in
                    Text(genre.capitalized).tag(genre)
                    
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if let currentMovie = currentMovie {
                VStack {
                    Text("Welcher Film ist das?")
                        .font(.headline)
                        .padding()
                 
                    AsyncImage(url: URL(string: currentMovie.poster))
                        .frame(width: 400, height: 350)
                        .clipped()
                        .cornerRadius(8)
                        .shadow(radius: 10)
//                        .blur(radius: blurAmount)
//                        .onAppear {
//                            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { timer in
//                                if blurAmount > 0 {
//                                    blurAmount -= 0.7
//                                } else {
//                                    timer.invalidate()
//                            }
//                        }
//                    }
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
        .onChange(of: selectedGenre) { oldValue, newValue in
            loadMovies()
        }
    }
    
    private func loadMovies() {
            self.currentMovie = nil
            self.movies = []

            // Servis çağrısı yaparak belirlenen kategoriye göre filmleri çekiyoruz.
            service.fetchMovies(by: selectedGenre) { result in
                switch result {
                case .success(let movies):
                    self.movies = movies
                    
                    if let randomMovie = movies.randomElement() {
                        self.currentMovie = randomMovie

                        // Rastgele iki film seçiyoruz, biri doğru seçenek, diğeri yanlış.
                        let otherMovies = movies.filter { $0.title != randomMovie.title }.shuffled().prefix(1)
                        self.movieOptions = [randomMovie.title] + otherMovies.map { $0.title }.shuffled()
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
