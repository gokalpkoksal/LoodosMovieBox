//
//  SearchMovieViewModelTests.swift
//  LoodosMovieBoxTests
//
//  Created by Gökalp Köksal on 1.05.2022.
//

import XCTest
@testable import LoodosMovieBox

class SearchMovieViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccess() {
        // Given search movie services available
        let movie = Movie(title: "MockMovie", year: "1996", image: "")
        let mockService = MockMovieService(getMoviesResult: .success(movie))
        let viewModel = SearchMovieViewModel(movieService: mockService)
        let view = MockSearchMovieView()
        viewModel.delegate = view
        
        // When view is shown
        viewModel.searchMovie(name: "asd")
        
        // Then correct amount of events fired
        XCTAssertEqual(view.events.count, 4)
        XCTAssertEqual(
            view.events,
            [.setLoading(true), .setLoading(false), .addMovie(movie: movie), .reloadTableData]
        )
    }

}

class MockMovieService: MovieServiceProtocol {
    
    private let getMoviesResult: Result<Movie, Error>
    
    init(getMoviesResult: Result<Movie, Error>) {
        self.getMoviesResult = getMoviesResult
    }

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
