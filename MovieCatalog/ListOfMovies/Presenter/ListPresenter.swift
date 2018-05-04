//
//  ListPresenter.swift
//  MovieCatalog
//
//  Created by Katerina on 04.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation

protocol ListMoviesPresenterOutput: class {
    func displayData(movies: [Movie])
    func displayError()
}

class ListPresenter: NSObject {
    
    private var output: ListMoviesPresenterOutput!
    private var movies: [Movie] = []
    
    // MARK: - Initializers
    init(output: ListMoviesPresenterOutput) {
        super.init()
        self.output = output
    }
}

// MARK: - ListMoviesInteractorOutput
extension ListPresenter: ListMoviesInteractorOutput {
    func presentFailure() {
        
    }
    
    func presentData(movies: [Movie]) {
        self.movies = movies
        output.displayData(movies: movies)
    }
}
