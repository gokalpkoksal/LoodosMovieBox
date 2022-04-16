//
//  ViewController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import UIKit

class SearchMovieViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SearchMovieDelegate {
    
    var viewModel = SearchMovieViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    private var movies = [Movie]()
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Movies"
        viewModel.delegate = self
        configureTableView()
        createSearchBar()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    private func createSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // do nothing
    }
    
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            fatalError()
        }
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // go to the selected movie's details
        let storyboard = UIStoryboard(name: "MovieDetails", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        vc.movie = self.movies[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movies.removeAll()
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        viewModel.searchMovie(name: text)
    }
    
    func addMovie(movie: Movie) {
        self.movies.append(movie)
    }
    
    func reloadTableData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

