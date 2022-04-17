//
//  LauncScreenViewController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import Foundation
import FirebaseRemoteConfig
import UIKit
import Network

class SplashScreenViewController: UIViewController, SplashScreenDelegate {
    
    public private(set) var isConnectedToInternet: Bool = false
    var viewModel = SplashScreenViewModel()
    var timer: Timer = Timer()
    var counter = 0

    @IBOutlet weak var loodosLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.checkInternetConnection()
    }

    func showNoInternetConnectionAlert() {
        let alert = UIAlertController(title: "No Internet", message: "This app requires internet connection!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateLogoText(text: String) {
        loodosLabel.text = text
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(threeSecondsCounter), userInfo: nil, repeats: true)
    }
    
    @objc func threeSecondsCounter() {
        counter = counter + 1
        if counter == 2 {
            timer.invalidate()
            navigateToSearchMovieController()
        }
    }
    
    private func navigateToSearchMovieController() {
        let storyboard = UIStoryboard(name: "SearchMovie", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else { return }
        self.present(vc, animated: true, completion: nil)
    }
}
