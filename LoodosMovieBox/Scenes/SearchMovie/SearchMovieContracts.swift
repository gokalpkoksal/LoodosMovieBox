//
//  SearchMovieContracts.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 15.04.2022.
//

import Foundation

protocol SearchMovieDelegate: AnyObject {
    func addMovie(movie: Movie)
    func reloadTableData()
    func setLoading(_ isAnimating: Bool)
    func showNoSuchMovieAlert()
}

protocol SearchMovieViewModelProtocol {
    var delegate: SearchMovieDelegate? { get set }
    func searchMovie(name: String)
}
