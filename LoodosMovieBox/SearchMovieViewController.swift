//
//  ViewController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import UIKit

class SearchMovieViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {

    // let searchController = UISearchController()
    
    private var viewModels = [MovieTableViewCellViewModel]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Movies"
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // searchController.searchResultsUpdater = self
        
        APICaller.shared.getMovies { [weak self] result in
            switch result {
            case .success(let movie):
                let viewModel = MovieTableViewCellViewModel(title: movie.Title, year: movie.Year)
                self?.viewModels.append(viewModel)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // go to the selected movie's details
    }

}

