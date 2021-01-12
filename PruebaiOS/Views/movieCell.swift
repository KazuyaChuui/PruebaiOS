//
//  movieCell.swift
//  iOSTest
//
//  Created by Jesus Ruiz on 1/10/21.
//

import UIKit

class movieCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }
    
    func configure(with movie: Movie?, url: String?) {
        if movie != nil {
            name.text = movie?.title
            date.text = movie?.releaseDate
            if let ratingQ = movie?.rating {
                rating.text = String(format: "%.1f", ratingQ)
            }
            let imageURL = URL(string: url!)!
            if let data = try? Data(contentsOf: imageURL) {
                indicatorView.stopAnimating()
                indicatorView.isHidden = true
                poster.image = UIImage(data: data)
            }
        }
    }

}
