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
    
    init(title: String, year: String) {
        self.title = title
        self.year = year
    }
    
    init() {
        self.title = ""
        self.year = ""
    }
    
    public enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
    }
}
