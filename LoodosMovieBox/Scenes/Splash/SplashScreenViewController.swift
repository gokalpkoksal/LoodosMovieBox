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
    
    let reachability = try! Reachability()
    var viewModel = SplashScreenViewModel()
    var timer: Timer = Timer()
    var counter = 0

    @IBOutlet weak var loodosLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        loodosLabel.text = "loodos(default)"
        checkInternetConnection()
        viewModel.fetchRemoteLogoText()
    }
    
    private func checkInternetConnection() {
        reachability.whenUnreachable = { _ in
            self.showNoInternetConnectionAlert()
        }
    }
    
    private func showNoInternetConnectionAlert() {
        let alert = UIAlertController(title: "No Internet", message: "This app requires internet connection!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
        self.present(alert, animated: true, completion: nil)
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
