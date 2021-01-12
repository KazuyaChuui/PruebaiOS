//
//  Details.swift
//  iOSTest
//
//  Created by Jesus Ruiz on 1/11/21.
//

import Foundation

struct Details: Decodable {
    let backdropPath: String
    let genres: [Genre]
    let overview: String
    let title: String
    let releaseDate: String
    let runtime: Int
    let rating: Double
    
    private enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres
        case overview
        case title
        case releaseDate = "release_date"
        case runtime
        case rating = "vote_average"
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
