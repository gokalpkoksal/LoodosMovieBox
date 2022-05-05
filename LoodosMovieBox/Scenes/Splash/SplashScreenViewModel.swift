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
    
    init(networkMonitor: NetworkMonitorProtocol, appNameService: AppNameServiceProtocol, timer: TimerProtocol) {
        self.networkMonitor = networkMonitor
        self.appNameService = appNameService
        self.timer = timer
    }
    
    func start() {
        if networkMonitor.isConnected {
            appNameService.getAppName { appName in
                self.delegate?.updateLogoText(text: appName)
                self.timer.startTimer(durationInSeconds: 3) {
                    self.delegate?.navigateToSearchMovieController()
                }
            }
        } else {
            delegate?.showNoInternetConnectionAlert()
        }
    }

}
