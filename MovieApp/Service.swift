//
//  Service.swift
//  MovieApp
//
//  Created by Tolga Sarikaya on 18.07.24.
//

import Foundation

class Service {
    
    func fetchData(for title: String, completion: @escaping (Result<Movie, Error>) -> Void) {
        let apiKey = "fbf719d2"
        let urlString = "http://www.omdbapi.com/?apikey=\(apiKey)&t=\(title)"
        
        
        
    }
}
