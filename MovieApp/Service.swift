//
//  Service.swift
//  MovieApp
//
//  Created by Tolga Sarikaya on 18.07.24.
//

import Foundation

class Service:  ObservableObject {
    @Published var movies: [Movie] = []
    
    func fetchData(titles: [String], completion: @escaping (Result<[Movie], Error>) -> Void) {
        let apiKey = "fbf719d2"
        let group = DispatchGroup()
        var movies: [Movie] = []
        var errors: [Error] = []
        
        for title in titles {
            group.enter()
            let urlString = "https://www.omdbapi.com/?apikey=\(apiKey)&t=\(title)"
            guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
                completion(.failure(NSError(domain: "Invalid Url", code: -1, userInfo: nil)))
                group.leave()
                continue
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    errors.append(error)
                    group.leave()
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                    group.leave()
                    return
                }
                
                do {
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    movies.append(movie)
                } catch {
                    errors.append(error)
                }
                group.leave()
            }.resume()
            
        }
        
        group.notify(queue: .main) {
            if errors.isEmpty {
                completion(.success(movies))
            } else {
                completion(.failure(errors.first!))
            }
        }
    }
    
    func fetchFilm(for title: String, completion: @escaping (Result<Movie, Error>) -> Void) {
        let apiKey = "fbf719d2"
        let urlString = "https://www.omdbapi.com/?apikey=\(apiKey)&t=\(title)"
        
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                completion(.success(movie))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
