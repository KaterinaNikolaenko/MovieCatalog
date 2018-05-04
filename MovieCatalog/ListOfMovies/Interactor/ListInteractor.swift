//
//  ListInteractor.swift
//  MovieCatalog
//
//  Created by Katerina on 04.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import Foundation

protocol ListMoviesInteractorOutput {
    func presentData(movies: [Movie])
    func presentFailure()
}

class ListInteractor: NSObject {
    
    private var movies: [Movie] = []
    private var filterMovies: [Movie] = []
    private var output: ListMoviesInteractorOutput!
    
    // MARK: - Initializers
    init(output: ListMoviesInteractorOutput) {
        super.init()
        self.output = output
    }
}

// MARK: - ListMoviesViewControllerOutput
extension ListInteractor: ListMoviesViewControllerOutput {
    func findList(filterText: String) {
        filterMovies = movies.filter({$0.title.contains(filterText) || $0.yearOfProduction.contains(filterText) || ($0.description?.contains(filterText))! || ($0.genre?.contains(filterText))!})
        output.presentData(movies: filterMovies)
    }
    
    func displayList() {
        movies.append(Movie(title: "aaaaaa", yearOfProduction: "2017", description: "djnjfdjkldfglkfjg"))
        movies.append(Movie(title: "ddddddd", yearOfProduction: "2017", description: "djnjfdjkldfglkfjg"))
        movies.append(Movie(title: "hhhhhhhh", yearOfProduction: "2017", description: "djnjfdjkldfglkfjg"))
        movies.append(Movie(title: "iiiiioooo", yearOfProduction: "2017", description: "djnjfdjkldfglkfjg"))
        movies.append(Movie(title: "pppppp", yearOfProduction: "2017", description: "djnjfdjkldfglkfjg"))
        movies.append(Movie(title: "wwwwww", yearOfProduction: "2017", description: "djnjfdjkldfglkfjg"))
        movies.append(Movie(title: "bbbbbb", yearOfProduction: "2017", description: "djnjfdjkldfglkfjg"))
        
        output.presentData(movies: movies)
    }
}
