//
//  Model.swift
//  MovieApp
//
//  Created by Tolga Sarikaya on 18.07.24.
//

import Foundation

struct Movie: Codable {
    let title: String
    let year: String
    let rated: String
    let released: String
    let genre: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case genre = "Genre"
    }
}
