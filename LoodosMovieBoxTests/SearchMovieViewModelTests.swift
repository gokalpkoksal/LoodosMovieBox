//
//  SearchMovieViewModelTests.swift
//  LoodosMovieBoxTests
//
//  Created by Gökalp Köksal on 1.05.2022.
//

import XCTest
@testable import LoodosMovieBox

class SearchMovieViewModelTests: XCTestCase {

    var mockService: MockMovieService!
    var viewModel: SearchMovieViewModel!
    var view: MockSearchMovieView!
    
    override func setUpWithError() throws {
        mockService = MockMovieService()
        viewModel = SearchMovieViewModel(movieService: mockService)
        view = MockSearchMovieView()
        viewModel.delegate = view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() {
        // Given search movie services available
        let movie = Movie(title: "MockMovie", year: "1996", image: "")
        mockService.getMoviesResult = .success(movie)

        // When view is shown
        viewModel.searchMovie(name: "asd")
        
        // Then correct amount of events fired
        XCTAssertEqual(view.events.count, 4)
        XCTAssertEqual(
            view.events,
            [.setLoading(true), .setLoading(false), .addMovie(movie: movie), .reloadTableData]
        )
    }
    
    func testFailure() {
        // Given search movie services fail (by deault)
        
        // When view is shown
        viewModel.searchMovie(name: "asd")
        
        // Then correct events fired
        var events = view.events.makeIterator()
        XCTAssertEqual(events.next(), .setLoading(true))
        XCTAssertEqual(events.next(), .setLoading(false))
        XCTAssertEqual(events.next(), .showNoSuchMovieAlert)
        
    }

}

class MockMovieService: MovieServiceProtocol {
    
    struct NoResponseError: Error {}
    
    var getMoviesResult: Result<Movie, Error> = .failure(NoResponseError())

    func getMovies(with title: String, completion: @escaping (Result<Movie, Error>) -> Void) {
        completion(getMoviesResult)
    }
}

class MockSearchMovieView: SearchMovieDelegate {
    
    var events: [Event] = []
    
    enum Event: Equatable {
        case addMovie(movie: Movie)
        case reloadTableData
        case setLoading(_ isAnimating: Bool)
        case showNoSuchMovieAlert
    }
    
    func addMovie(movie: Movie) {
        events.append(Event.addMovie(movie: movie))
    }
    
    func reloadTableData() {
        events.append(Event.reloadTableData)
    }
    
    func setLoading(_ isAnimating: Bool) {
        events.append(Event.setLoading(isAnimating))
    }
    
    func showNoSuchMovieAlert() {
        events.append(Event.showNoSuchMovieAlert)
    }
    
}
