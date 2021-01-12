//
//  DetailController.swift
//  iOSTest
//
//  Created by Jesus Ruiz on 1/10/21.
//

import Foundation
import Alamofire

extension detailView {
    
    //MARK: Fetch Genres
    func fetchDetails() {
        let url = "https://api.themoviedb.org/3/movie/\(movieId)"
        let parameters = ["api_key": apiKey, "language": "es-MX"]
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: Details.self) { (response) in
                switch response.result {
                    case .success(let value):
                        self.details = value
                        self.loadImage()
                        self.loadDetails()
                    case .failure(let error):
                        print(error)
                }
            }
    }
    
    func loadImage() {
        let url = imageSizes.secureURL+imageSizes.backdropSizes[0]+details.backdropPath
        
        let imageURL = URL(string: url)!
        if let data = try? Data(contentsOf: imageURL) {
            backdrop.image = UIImage(data: data)
        }
        
    }
    
    func loadDetails() {
        name.text = details.title
        runtime.text = "\(details.runtime) min"
        date.text = details.releaseDate
        rating.text = "\(details.rating)"
        overview.text = details.overview
        for genre in details.genres {
            if details.genres.count == 1 {
                self.genre.text = genre.name
            } else {
                if genre.id != details.genres[0].id {
                    self.genre.text = self.genre.text! + ", " + genre.name
                } else {
                    self.genre.text = genre.name
                }
            }
        }
    }
    
}
