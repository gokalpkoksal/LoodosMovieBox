//
//  ViewController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import UIKit

class SearchMovieViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SearchMovieDelegate {
    
    var viewModel = SearchMovieViewModel(movieService: APICaller.shared)
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var movies = [Movie]()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Movies"
        viewModel.delegate = self
        configureActivityIndicator()
        configureTableView()
        createSearchBar()
    }
    
    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicator.style = .large
        activityIndicator.isHidden = true
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
        
        if (text.lowercased().rangeOfCharacter(from: CharacterSet(charactersIn: "öüığş")) != nil) {
            showSpecialCharNotAllowedAlert()
        } else {
            viewModel.searchMovie(name: text)
        }
    }
    
    func showSpecialCharNotAllowedAlert() {
        let alert = UIAlertController(title: "Special Character Detected", message: "Special characters are not allowed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func addMovie(movie: Movie) {
        self.movies.append(movie)
    }
    
    func reloadTableData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setLoading(_ isLoading: Bool) {
        if isLoading {
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            }
        } else {
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func showNoSuchMovieAlert() {
        let alert = UIAlertController(title: "Not Found", message: "The movie you searched was not found", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

