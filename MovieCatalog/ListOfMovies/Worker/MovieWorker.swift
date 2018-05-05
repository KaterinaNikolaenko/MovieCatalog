//
//  MovieWorker.swift
//  MovieCatalog
//
//  Created by Katerina on 05.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation
import RealmSwift

class MovieWorker: NSObject {
    
    func getMovies() -> [Movie] {
        return DBManager.sharedInstance.getDataFromDB()
    }
    
    func saveMovie(movie: Movie, completion: (Bool) -> ()) {
        DBManager.sharedInstance.addData(object: movie)
        completion(true)
    }
}
