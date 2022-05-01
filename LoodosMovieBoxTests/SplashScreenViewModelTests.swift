//
//  LoodosMovieBoxTests.swift
//  LoodosMovieBoxTests
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import XCTest
@testable import LoodosMovieBox

class SplashScreenViewModelTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testStart() throws {
        // Given Internet available
        let monitor = MockNetworkMonitor()
        monitor.isConnected = true
        let appNameService = MockAppNameService()
        appNameService.appName = "Loodos"
        let viewModel = SplashScreenViewModel(networkMonitor: monitor, appNameService: appNameService)
        let view = MockView()
        viewModel.delegate = view
        
        // When view is shown
        viewModel.start()
        
        // Then Loodos Logo appears
        XCTAssertEqual(view.events, [.updateLogoText(text: "Loodos")] )
    }
    
    func testStartWithoutInternet() {
        // Given Internet not available
        let monitor = MockNetworkMonitor()
        monitor.isConnected = false
        
        let appNameService = MockAppNameService()
        let viewModel = SplashScreenViewModel(networkMonitor: monitor, appNameService: appNameService)
        let view = MockView()
        viewModel.delegate = view
        
        // When view is shown
        viewModel.start()
        
        // Then no internet connection alert appears
        XCTAssertEqual(view.events, [.showNoInternetConnectionAlert])
        
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
