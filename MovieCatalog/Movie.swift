//
//  Movie.swift
//  MovieCatalog
//
//  Created by Katerina on 04.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation

class Movie {
    var id: String
    var title: String
    var genre: String?
//    var poster: Data?
    var yearOfProduction: String
    var description: String?
    
    init(title: String, genre: String? = "", yearOfProduction: String, description: String? = "") {
        self.id = UUID().uuidString
        self.title = title
        self.genre = genre
        //self.poster = poster
        self.yearOfProduction = yearOfProduction
        self.description = description
    }
}
