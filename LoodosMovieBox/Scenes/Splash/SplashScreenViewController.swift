//
//  LauncScreenViewController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import Foundation
import UIKit

class SplashScreenViewController: UIViewController, SplashScreenDelegate {
    
    var viewModel = SplashScreenViewModel(networkMonitor: NetworkMonitor.shared, appNameService: FirebaseService(), timer: TimerController())

    @IBOutlet weak var loodosLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.start()
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
    }
    
    func navigateToSearchMovieController() {
        let storyboard = UIStoryboard(name: "SearchMovie", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else { return }
        self.present(vc, animated: true, completion: nil)
    }
}
