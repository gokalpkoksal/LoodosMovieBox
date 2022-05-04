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
        
        XCTAssertEqual(mockAnalyticsService.eventLogged, true)
    }
}

class MockFirebaseAnalyticsService: FirebaseAnalyticsServiceProtocol {

    var eventLogged = false
    
    func logEvent(name: String, parameters: [String : Any]?) {
        eventLogged = true
    }
}
