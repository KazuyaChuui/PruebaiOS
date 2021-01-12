//
//  DetailView.swift
//  iOSTest
//
//  Created by Jesus Ruiz on 1/10/21.
//

import UIKit

class detailView: UIViewController {
    
    var movieId = 0
    var imageSizes = ImageSize(baseURL: "", secureURL: "", backdropSizes: [""], posterSizes: [""])
    var details = Details(backdropPath: "", genres: [Genre(id: 1, name: "")], overview: "", title: "", releaseDate: "", runtime: 1, rating: 1)
    
    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var overview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetails()
    }


}
