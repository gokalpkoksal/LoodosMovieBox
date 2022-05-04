//
//  MovieDetailsViewModel.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 20.04.2022.
//

import Foundation

enum AnalyticsEventName {
    static let movieDetails = "movieDetails"
}

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    private let analyticsService: FirebaseAnalyticsServiceProtocol
    
    init(analyticsService: FirebaseAnalyticsServiceProtocol) {
        self.analyticsService = analyticsService
    }
    
    func logEvent(movie: Movie) {
        let parameters = ["movie name" : movie.title as NSObject,
                          "movie year" : movie.year as NSObject]
        analyticsService.logEvent(name: AnalyticsEventName.movieDetails, parameters: parameters)
    }
}
