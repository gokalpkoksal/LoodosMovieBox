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
    
    func testStart() throws {
        // Given a movie
        let view = MockMovieDetailsView()
        let mockService = MockFirebaseAnalyticsService()
        let viewModel = MovieDetailsViewModel(analyticsService: mockService)
        viewModel.delegate = view
        
        // When view is shown
        viewModel.start(movie: Movie(title: "Movie Test", year: "2000", image: ""))
        
        // Then title and image is updated on view
        var events = view.events.makeIterator()
        XCTAssertEqual(events.next(), .setContentInformation(movieTitle: "Movie Test", movieImageUrlString: ""))
        XCTAssertEqual(events.next(), nil)
    }

    func testLogEvent() throws {
        // Given a mock firebase analytics service
        let mockAnalyticsService = MockFirebaseAnalyticsService()
        let viewModel = MovieDetailsViewModel(analyticsService: mockAnalyticsService)
        
        // When logEvent called
        viewModel.logEvent(movie: Movie(title: "Movie Test", year: "2000", image: ""))
        
        // logEvent fired with correct parameters
        let parameters = mockAnalyticsService.parameters
        XCTAssertEqual(mockAnalyticsService.eventName, AnalyticsEventName.movieDetails)
        XCTAssertEqual(parameters[AnalyticsEventParameterName.movieName] as! String, "Movie Test")
        XCTAssertEqual(parameters[AnalyticsEventParameterName.movieYear] as! String, "2000")
        XCTAssertEqual(parameters.count, 2)
        XCTAssertEqual(mockAnalyticsService.eventLogged, true)
    }
}

class MockMovieDetailsView: MovieDetailsDelegate {
    
    var events = [MovieDetailsEvent]()
    
    enum MovieDetailsEvent: Equatable {
        case setContentInformation(movieTitle: String, movieImageUrlString: String)
    }
    
    func setContentInformation(movieTitle: String, movieImageUrlString: String) {
        events.append(.setContentInformation(movieTitle: movieTitle, movieImageUrlString: movieImageUrlString))
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
