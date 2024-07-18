//
//  ContentView.swift
//  MovieApp
//
//  Created by Tolga Sarikaya on 18.07.24.
//

import SwiftUI

struct ContentView: View {
    @State private var movieTitle: String = ""
    @State private var movie: Movie?
    @StateObject private var service = Service()
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
          TextField("Enter the movie name", text: $movieTitle)
                .padding()
            
            Button("Search") {
                service.fetchData(for: movieTitle) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let movie):
                            self.movie = movie
                            self.errorMessage = nil
                            case .failure(let error):
                            self.errorMessage = error.localizedDescription
                            self.movie = nil
                        }
                    }
                }
            }
            .padding()
            
            if let movie = movie {
                            Text("Title: \(movie.title)")
                            Text("Jahr: \(movie.year)")
                            Text("Punkte: \(movie.rated)")
                            Text("Veröffentlichungsdatum: \(movie.released)")
                            Text("Art: \(movie.genre)")
            }
              if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                .foregroundColor(.red)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
