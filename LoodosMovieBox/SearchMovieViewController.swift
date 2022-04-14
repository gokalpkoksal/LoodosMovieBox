//
//  ViewController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import UIKit

class SearchMovieViewController: UIViewController, UISearchResultsUpdating {

    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Movies"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let typedMovieName = searchController.searchBar.text else {
            return
        }
        searchMovie(typedMovieName)
    }
    
    private func searchMovie(_ movieName: String) {
        // TODO: search the movie
    }

}

