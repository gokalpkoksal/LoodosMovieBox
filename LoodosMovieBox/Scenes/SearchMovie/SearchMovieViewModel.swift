//
//  SearchMovieViewModel.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 15.04.2022.
//

import Foundation

final class SearchMovieViewModel {
    weak var delegate: SearchMovieDelegate?
    
    init() { }
    
    func searchMovie(name: String) {
        APICaller.shared.getMovies(with: name) { [weak self] result in
            switch result {
            case .success(let movie):
                let viewModel = MovieTableViewCellViewModel(title: movie.Title, year: movie.Year)
                self?.delegate?.addMovie(movie: viewModel)
                self?.delegate?.reloadTableData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
