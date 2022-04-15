//
//  MovieDetailsViewController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 15.04.2022.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    var movie = Movie()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        movieNameLabel.text = movie.title
    }
}
