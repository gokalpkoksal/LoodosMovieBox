//
//  MovieDetailsViewModel.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 20.04.2022.
//

import Foundation

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    private let analyticsService: FirebaseAnalyticsServiceProtocol
    
    init(analyticsService: FirebaseAnalyticsServiceProtocol) {
        self.analyticsService = analyticsService
    }
    
    func logEvent(movie: Movie) {
        let parameters = [AnalyticsEventParameterName.movieName : movie.title as NSObject,
                          AnalyticsEventParameterName.movieYear : movie.year as NSObject]
        analyticsService.logEvent(name: AnalyticsEventName.movieDetails, parameters: parameters)
    }
}
