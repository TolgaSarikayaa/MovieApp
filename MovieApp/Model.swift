//
//  Model.swift
//  MovieApp
//
//  Created by Tolga Sarikaya on 18.07.24.
//

import Foundation

struct Movie: Identifiable, Decodable {
    var id: String { imdbID }
    let title: String
    let year: String
    let poster: String
    let imdbID: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
        case imdbID = "imdbID"
    }
}


    
