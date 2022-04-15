//
//  Movie.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 14.04.2022.
//

import Foundation


public struct Movie: Codable {
    let title: String
    let year: String
    var image: String
    
    init(title: String, year: String, image: String) {
        self.title = title
        self.year = year
        self.image = image
    }
    
    init() {
        self.title = ""
        self.year = ""
        self.image = ""
    }
    
    public enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case image = "Poster"
    }
}
