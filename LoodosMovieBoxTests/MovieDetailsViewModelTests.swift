//
//  MovieDetailsViewModelTests.swift
//  LoodosMovieBoxTests
//
//  Created by Gökalp Köksal on 4.05.2022.
//

import XCTest
@testable import LoodosMovieBox

class MovieDetailsViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogEvent() throws {
        let mockAnalyticsService = MockFirebaseAnalyticsService()
        let viewModel = MovieDetailsViewModel(analyticsService: mockAnalyticsService)
        
        viewModel.logEvent(movie: Movie())
        
        let parameters = mockAnalyticsService.parameters
        XCTAssertEqual(mockAnalyticsService.eventLogged, true)
        XCTAssertEqual(mockAnalyticsService.eventName, AnalyticsEventName.movieDetails)
        XCTAssertEqual(parameters.count, 2)
        XCTAssertEqual(parameters.keys.contains(AnalyticsEventParameterName.movieName), true)
        XCTAssertEqual(parameters.keys.contains(AnalyticsEventParameterName.movieYear), true)
    }
}

class MockFirebaseAnalyticsService: FirebaseAnalyticsServiceProtocol {

    var eventLogged = false
    var eventName = ""
    var parameters: [String: Any] = [:]
    
    func logEvent(name: String, parameters: [String : Any]?) {
        if let parameters = parameters {
            self.parameters = parameters
        }
        self.eventName = name
        self.eventLogged = true
    }
}
