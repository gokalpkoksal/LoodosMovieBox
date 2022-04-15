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
    
    private init() {}
    
    public func getUrl(title: String) -> URL? {
        let urlString = "https://www.omdbapi.com/?t=\(title)&apikey=\(apiKey)"
        return URL(string: urlString)
    }
    
    public func getMovies(with title: String, completion: @escaping (Result<Movie, Error>) -> Void) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        guard let url = getUrl(title: title) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Movie.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
