//
//  MovieDetailsViewModel.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 20.04.2022.
//

import Foundation
import Firebase

final class MovieDetailsViewModel {
    
    init() { }
    
    func logEvent(movie: Movie) {
        Analytics.logEvent("movieDetails", parameters: [
            "movie name" : movie.title as NSObject,
            "movie year" : movie.year as NSObject
        ])
    }
}
