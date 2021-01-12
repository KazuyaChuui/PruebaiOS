//
//  Movies.swift
//  iOSTest
//
//  Created by Jesus Ruiz on 1/10/21.
//

import Foundation

struct Movie: Decodable {
    let id: Int!
    let posterPath: String
    let backdrop: String
    let title: String
    let releaseDate: String
    let rating: Double
    let overview: String
    //let genres: [Genre]?
    let genreIds: [Int]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdrop = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case overview
        case genreIds = "genre_ids"
    }
}


struct Movies: Decodable {
    let page: Int!
    let all: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case all = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
