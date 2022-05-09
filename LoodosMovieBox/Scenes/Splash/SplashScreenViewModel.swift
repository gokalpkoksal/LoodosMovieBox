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
    private let timer: TimerProtocol
    private var counter = 0
    
    init(networkMonitor: NetworkMonitorProtocol, appNameService: AppNameServiceProtocol, timer: TimerProtocol) {
        self.networkMonitor = networkMonitor
        self.appNameService = appNameService
        self.timer = timer
    }
    
    func start() {
        if networkMonitor.isConnected {
            appNameService.getAppName { appName in
                self.delegate?.updateLogoText(text: appName)
                self.timer.startTimer(interval: 1) {
                    self.counter += 1
                    if self.counter == 3 {
                        self.delegate?.navigateToSearchMovieController()
                        return true
                    }
                    return false
                }
            }
        } else {
            delegate?.showNoInternetConnectionAlert()
        }
    }

}
