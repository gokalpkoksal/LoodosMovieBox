//
//  MovieDetailsContracts.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 4.05.2022.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
    var delegate: MovieDetailsDelegate? { get set }
    func start(movie: Movie)
    func logEvent(movie: Movie)
}

protocol MovieDetailsDelegate: AnyObject {
    func setContentInformation(movieTitle: String, movieImageUrlString: String)
}
