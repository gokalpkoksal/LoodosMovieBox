//
//  LauncScreenViewController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import Foundation
import FirebaseRemoteConfig
import UIKit

class SplashScreenViewController: UIViewController, SplashScreenDelegate {
    
    var viewModel = SplashScreenViewModel()

    @IBOutlet weak var loodosLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        loodosLabel.text = "loodos(default)"
        viewModel.fetchRemoteLogoText()
    }
    
    func updateLogoText(text: String) {
        loodosLabel.text = text
    }
}
