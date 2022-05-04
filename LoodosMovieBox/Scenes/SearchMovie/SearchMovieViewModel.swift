//
//  SearchMovieViewModel.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 15.04.2022.
//

import Foundation

final class SearchMovieViewModel: SearchMovieViewModelProtocol {
    weak var delegate: SearchMovieDelegate?
    
    private let movieService: MovieServiceProtocol
    
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }
    
    func searchMovie(name: String) {
        self.delegate?.setLoading(true)
        movieService.getMovies(with: name) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.delegate?.setLoading(false)
                self?.delegate?.addMovie(movie: movie)
                self?.delegate?.reloadTableData()
                
            case .failure(let error):
                self?.delegate?.setLoading(false)
                self?.delegate?.showNoSuchMovieAlert()
            }
        }
    }
}
