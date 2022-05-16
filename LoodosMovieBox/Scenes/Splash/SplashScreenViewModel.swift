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
    
    private func startTimer() {
        timer.startTimer(interval: 1, tick: { [weak self] in
            guard let self = self else {
                return
            }
            self.counter += 1
            if self.counter == 3 {
                self.delegate?.navigateToSearchMovieController()
                self.timer.stopTimer()
            }
        })
    }
    
    func start() {
        if networkMonitor.isConnected {
            appNameService.getAppName { [weak self] appName in
                self?.delegate?.updateLogoText(text: appName)
                self?.startTimer()
            }
        } else {
            delegate?.showNoInternetConnectionAlert()
        }
    }

}
