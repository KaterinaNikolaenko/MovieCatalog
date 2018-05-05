//
//  ListInteractor.swift
//  MovieCatalog
//
//  Created by Katerina on 04.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation

protocol ListMoviesInteractorOutput {
    func presentData(movies: [Movie], filterMovies: [Movie]?)
    func presentFailure()
}

class ListInteractor: NSObject {
    
    private var movies: [Movie] = []
    private var filterMovies: [Movie] = []
    private var output: ListMoviesInteractorOutput!
    private var worker: MovieWorker!
    
    // MARK: - Initializers
    init(output: ListMoviesInteractorOutput) {
        super.init()
        self.output = output
        self.worker = MovieWorker()
    }
}

// MARK: - ListMoviesViewControllerOutput
extension ListInteractor: ListMoviesViewControllerOutput {
    func findList(filterText: String) {
        filterMovies = []
        filterMovies = movies.filter({$0.title.contains(filterText) || $0.yearOfProduction.contains(filterText) || ($0.movieDescription?.contains(filterText))! || ($0.genre?.contains(filterText))!})
        output.presentData(movies: movies, filterMovies: filterMovies)
    }
    
    func displayList() {
        movies = []
        movies = worker.getMovies()
        output.presentData(movies: movies, filterMovies: [])
    }
}
