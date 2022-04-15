//
//  ViewController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import UIKit

class SearchMovieViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private var viewModels = [MovieTableViewCellViewModel]()
    private let searchVC = UISearchController(searchResultsController: nil)
    
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
        createSearchBar()
    }
    
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //
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

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModels.removeAll()
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        APICaller.shared.getMovies(with: text) { [weak self] result in
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
}

