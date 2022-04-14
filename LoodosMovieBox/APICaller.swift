//
//  APICaller.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private let apiKey = "37e5bca1"
    
    var searchedTitle = "car"
    
    private init() {}
    
    public func getUrl(title: String, apiKey: String) -> URL? {
        let urlString = "https://www.omdbapi.com/?t=\(title)&apikey=\(apiKey)"
        return URL(string: urlString)
    }
    
    public func getMovies(completion: @escaping (Result<Movie, Error>) -> Void) {
        guard let url = getUrl(title: searchedTitle, apiKey: apiKey) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Movie.self, from: data)
                    
                    print("Movie count = \(result.Title)")
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

struct APIResponse: Codable {
    let movie: Movie
}
