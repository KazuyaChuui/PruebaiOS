//
//  MainView.swift
//  iOSTest
//
//  Created by Jesus Ruiz on 1/10/21.
//

import UIKit

class mainView: UIViewController {

    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    fileprivate let itemsPerRow: CGFloat = 2
    
    var items: [Movie] = []
    var imageSizes = ImageSize(baseURL: "", secureURL: "", backdropSizes: [""], posterSizes: [""])
    var pageNumber = 1
    var movieTotal = 0
    
    @IBOutlet weak var collectionV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCell()
        collectionV.prefetchDataSource = self
        fetchImageSizes()
        fetchMovies(page: pageNumber)
        configureRefreshControl()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            let index = (sender as! NSIndexPath)
            if let destinationVC = segue.destination as? detailView {
                destinationVC.imageSizes = self.imageSizes
                destinationVC.movieId = items[index.row].id
            }
        }
    }

}

// MARK: UICollectionView
extension mainView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieTotal
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! movieCell
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none, url: .none)
            } else {
                let url = imageSizes.secureURL+imageSizes.posterSizes[3]+items[indexPath.row].posterPath
                cell.configure(with: items[indexPath.row], url: url)
            }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSegue", sender: indexPath)
    }
}

extension mainView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            self.fetchMovies(page: pageNumber)
          }
    }
}

extension mainView: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionV.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
