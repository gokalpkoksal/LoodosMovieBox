//
//  MovieDetailsViewController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 15.04.2022.
//

import Foundation
import UIKit
import Kingfisher
import Firebase

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    var movie = Movie()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        Analytics.logEvent("movieDetails", parameters: [
            "movie name" : movie.title as NSObject,
            "movie year" : movie.year as NSObject
        ])
        movieNameLabel.text = movie.title
        setImage()
    }
    
    func setImage() {
        if movie.image != "" {
            movieImageView.kf.indicatorType = .activity
            movieImageView.kf.setImage(with: URL(string: movie.image), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        }
    }
}
