//
//  ListPresenter.swift
//  MovieCatalog
//
//  Created by Katerina on 04.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation

protocol ListMoviesPresenterOutput: class {
    func displayData(movies: [Movie], filterMovies: [Movie]?)
    func displayError()
}

class ListPresenter: NSObject {
    
    private var output: ListMoviesPresenterOutput!
    private var movies: [Movie] = []
    private var filterMovies: [Movie] = []
    
    // MARK: - Initializers
    init(output: ListMoviesPresenterOutput) {
        super.init()
        self.output = output
    }
}

// MARK: - ListMoviesInteractorOutput
extension ListPresenter: ListMoviesInteractorOutput {
    
    func presentFailure() {
        output.displayError()
    }
    
    func presentData(movies: [Movie], filterMovies: [Movie]?) {
        self.movies = movies
        self.filterMovies = filterMovies ?? []
        output.displayData(movies: movies, filterMovies: filterMovies)
    }
}
