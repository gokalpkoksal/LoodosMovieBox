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
        self.delegate?.setLoading(true)
        APICaller.shared.getMovies(with: name) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.delegate?.setLoading(false)
                self?.delegate?.addMovie(movie: movie)
                self?.delegate?.reloadTableData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
