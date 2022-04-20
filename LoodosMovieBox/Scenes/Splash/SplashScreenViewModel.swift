//
//  SplashScreenViewModel.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 15.04.2022.
//

import Foundation
import FirebaseRemoteConfig

final class SplashScreenViewModel {
    weak var delegate: SplashScreenDelegate?
    private var connectedToInternet = NetworkMonitor.shared.isConnected
    
    init() { }
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    private var timer: Timer = Timer()
    private var counter = 0
    
    func start() {
        if connectedToInternet {
            fetchRemoteLogoText()
        } else {
            delegate?.showNoInternetConnectionAlert()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(threeSecondsCounter), userInfo: nil, repeats: true)
    }
    
    @objc private func threeSecondsCounter() {
        counter = counter + 1
        if counter == 2 {
            timer.invalidate()
            delegate?.navigateToSearchMovieController()
        }
    }
    
    private func fetchRemoteLogoText() {
        let defaults: [String: NSObject] = ["text_loodos_remote": "loodos_default" as NSObject]
        remoteConfig.setDefaults(defaults)
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        self.remoteConfig.fetch(withExpirationDuration: 0, completionHandler: { status, error in
            if status == .success, error == nil {
                self.remoteConfig.activate { _, error in
                    guard error == nil else {
                        return
                    }
                    
                    if let fetchedValue = self.remoteConfig.configValue(forKey: "text_loodos_remote").stringValue {
                        DispatchQueue.main.async {
                            self.delegate?.updateLogoText(text: fetchedValue)
                        }
                        print("fetched: \(fetchedValue)")
                    }
                }
            } else {
                print("sth went wrong!")
            }
        })
    }
}
