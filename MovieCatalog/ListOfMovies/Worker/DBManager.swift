//
//  DBManager.swift
//  MovieCatalog
//
//  Created by Katerina on 05.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation

import UIKit
import RealmSwift

class DBManager {
    private var database:Realm
    static let sharedInstance = DBManager()
    private init() {
        database = try! Realm()
    }
    func getDataFromDB() -> [Movie] {
        let results = database.objects(Movie.self).toArray(ofType: Movie.self) as [Movie]
        return results
    }
    func addData(object: Movie)   {
        try! database.write {
            database.add(object, update: false)
        }
    }
}
