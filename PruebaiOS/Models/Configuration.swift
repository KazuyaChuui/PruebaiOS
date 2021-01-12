//
//  Configuration.swift
//  iOSTest
//
//  Created by Jesus Ruiz on 1/11/21.
//

import Foundation

let apiKey = "634b49e294bd1ff87914e7b9d014daed"

struct ImagesData: Decodable {
    let images: ImageSize
    private enum CodingKeys: String, CodingKey {
        case images
    }
}

struct ImageSize: Decodable {
    let baseURL: String
    let secureURL: String
    let backdropSizes: [String]
    let posterSizes: [String]
    
    private enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureURL = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case posterSizes = "poster_sizes"
    }
}
