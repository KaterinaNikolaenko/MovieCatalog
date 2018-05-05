//
//  Movie.swift
//  MovieCatalog
//
//  Created by Katerina on 04.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Movie: Object {
    @objc dynamic var id = "0"
    @objc dynamic var title: String!
    @objc dynamic var genre: String?
    @objc dynamic var poster: NSData?
    @objc dynamic var yearOfProduction: String!
    @objc dynamic var movieDescription: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(title: String, genre: String? = "", poster: NSData? = NSData(data: UIImagePNGRepresentation(UIImage(named: "placeholder")!)!) , yearOfProduction: String, movieDescription: String? = "") {
        self.init()
        self.id = NSUUID().uuidString
        self.title = title
        self.genre = genre
        self.poster = poster!
        self.yearOfProduction = yearOfProduction
        self.movieDescription = movieDescription
    }
}


