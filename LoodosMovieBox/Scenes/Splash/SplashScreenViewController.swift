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
    var timer: Timer = Timer()
    var counter = 0

    @IBOutlet weak var loodosLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        loodosLabel.text = "loodos(default)"
        viewModel.fetchRemoteLogoText()
    }
    
    func updateLogoText(text: String) {
        loodosLabel.text = text
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(threeSecondsCounter), userInfo: nil, repeats: false)
    }
    
    @objc func threeSecondsCounter() {
        counter = counter + 1
        if counter == 3 {
            timer.invalidate()
            navigateToSearchMovieController()
        }
    }
    
    private func navigateToSearchMovieController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchMovieViewController") as! SearchMovieViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
