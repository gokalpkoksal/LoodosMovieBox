//
//  MovieDetailsViewController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 15.04.2022.
//

import Foundation
import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController, MovieDetailsDelegate {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    var viewModel = MovieDetailsViewModel(analyticsService: AnalyticsService())
    var movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.start(movie: movie)
    }
    
    func setContentInformation(movieTitle: String, movieImageUrlString: String) {
        movieNameLabel.text = movieTitle
        
        if movieImageUrlString != "" {
            movieImageView.kf.indicatorType = .activity
            movieImageView.kf.setImage(with: URL(string: movieImageUrlString), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        }
    }
}
// TODO: Movie cannot be in View Layer
