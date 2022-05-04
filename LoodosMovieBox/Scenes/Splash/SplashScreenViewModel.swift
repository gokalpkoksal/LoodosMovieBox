//
//  SplashScreenViewModel.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 15.04.2022.
//

import Foundation

final class SplashScreenViewModel: SplashScreenViewModelProtocol {
    
    weak var delegate: SplashScreenDelegate?
    private let networkMonitor: NetworkMonitorProtocol
    private let appNameService: AppNameServiceProtocol
    
    init(networkMonitor: NetworkMonitorProtocol, appNameService: AppNameServiceProtocol) {
        self.networkMonitor = networkMonitor
        self.appNameService = appNameService
    }
    private var timer: Timer = Timer()
    private var counter = 0
    
    func start() {
        if networkMonitor.isConnected {
            appNameService.getAppName { appName in
                self.delegate?.updateLogoText(text: appName)
                self.startTimer()
            }
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
}
