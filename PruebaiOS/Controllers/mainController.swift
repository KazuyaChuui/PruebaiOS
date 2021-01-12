//
//  MainController.swift
//  iOSTest
//
//  Created by Jesus Ruiz on 1/10/21.
//

import UIKit
import Alamofire

extension mainView {
    
    func registerCollectionViewCell() {
        let dynamicCell = UINib(nibName: "movieCell", bundle: nil)
        self.collectionV.register(dynamicCell, forCellWithReuseIdentifier: "movieCell")
    }
    
    //MARK: Fetch Movies
    func fetchMovies(page: Int) {
        let url = "https://api.themoviedb.org/3/movie/now_playing"
        let parameters = ["api_key": apiKey, "language": "es-MX", "page": "\(page)"]
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: Movies.self) { (response) in
                switch response.result {
                    case .success(let value):
                        self.pageNumber += 1
                        self.movieTotal = value.totalResults
                        self.items.append(contentsOf: value.all)
                        
                        if value.page > 1 {
                            let indexPathsToReload = self.calculateIndexPathsToReload(from: value.all)
                            self.onFetchCompleted(with: indexPathsToReload)
                        } else {
                            self.onFetchCompleted(with: .none)
                        }
                    case .failure(let error):
                        print(error)
                }
            }
    }
    
    //MARK: CollectionView Cell Setup
    
    private func calculateIndexPathsToReload(from newMovies: [Movie]) -> [IndexPath] {
      let startIndex = items.count - newMovies.count
      let endIndex = startIndex + newMovies.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
      return indexPath.row >= self.items.count
    }

    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleItems = collectionV.indexPathsForVisibleItems
      let indexPathsIntersection = Set(indexPathsForVisibleItems).intersection(indexPaths)
      return Array(indexPathsIntersection)
    }
    
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
      guard let newIndexPathsToReload = newIndexPathsToReload else {
        collectionV.reloadData()
        return
      }
      let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        self.collectionV.reloadItems(at: indexPathsToReload)
        
    }
    
    //MARK: Fetch Images
    
    func fetchImageSizes() {
        let url = "https://api.themoviedb.org/3/configuration"
        let parameters = ["api_key": apiKey]
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: ImagesData.self) { (response) in
                switch response.result {
                    case .success(let value):
                        self.imageSizes = value.images
                    case .failure(let error):
                        print(error)
                }
            }
    }
    
    //MARK: Pull to Refresh
    
    func configureRefreshControl () {
       collectionV.refreshControl = UIRefreshControl()
       collectionV.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
        pageNumber = 1
        fetchMovies(page: pageNumber)
       DispatchQueue.main.async {
          self.collectionV.refreshControl?.endRefreshing()
       }
    }
}
