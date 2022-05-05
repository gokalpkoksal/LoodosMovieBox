//
//  LoodosMovieBoxTests.swift
//  LoodosMovieBoxTests
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import XCTest
@testable import LoodosMovieBox

class SplashScreenViewModelTests: XCTestCase {
    
    var monitor: MockNetworkMonitor!
    var appNameService: MockAppNameService!
    var timer: MockTimer!
    var viewModel: SplashScreenViewModel!
    var view: MockView!
    
    override func setUpWithError() throws {
        monitor = MockNetworkMonitor()
        appNameService = MockAppNameService()
        timer = MockTimer()
        viewModel = SplashScreenViewModel(networkMonitor: monitor, appNameService: appNameService, timer: timer)
        view = MockView()
        viewModel.delegate = view
    }

    func testStart() throws {
        // Given Internet available and appName is "Loodos"
        monitor.isConnected = true
        appNameService.appName = "Loodos"
        
        // When view is shown and 3 seconds has passed
        viewModel.start()
        timer.finishCounting()
        
        // Then Loodos Logo appears
        var events = view.events.makeIterator()
        XCTAssertEqual(events.next(), .updateLogoText(text: "Loodos"))
        XCTAssertEqual(events.next(), .navigateToSearchMovieController)
        XCTAssertEqual(events.next(), nil)
    }
    
    func testStartWithoutInternet() {
        // Given Internet not available
        monitor.isConnected = false
        
        // When view is shown
        viewModel.start()
        
        // Then no internet connection alert appears
        var events = view.events.makeIterator()
        XCTAssertEqual(events.next(), .showNoInternetConnectionAlert)
        XCTAssertEqual(events.next(), nil)
    }

}

class MockTimer: TimerProtocol {
    
    var completion: (() -> Void)?
    
    func finishCounting() {
        if let completion = completion {
            completion()
        }
    }
    
    func startTimer(durationInSeconds: Double, completion: @escaping () -> Void) {
        self.completion = completion
    }
    
}

class MockNetworkMonitor: NetworkMonitorProtocol {
    var isConnected = true
    init() { }
}

class MockAppNameService: AppNameServiceProtocol {
    var appName: String = ""
    func getAppName(completion: @escaping (String) -> Void) {
        completion(appName)
    }
}

class MockView: SplashScreenDelegate {
    
    var events: [Event] = []
    
    enum Event: Equatable {
        case updateLogoText(text: String)
        case showNoInternetConnectionAlert
        case navigateToSearchMovieController
    }
    
    func updateLogoText(text: String) {
        events.append(Event.updateLogoText(text: text))
    }
    
    func showNoInternetConnectionAlert() {
        events.append(Event.showNoInternetConnectionAlert)
    }
    
    func navigateToSearchMovieController() {
        events.append(Event.navigateToSearchMovieController)
    }
    
}
