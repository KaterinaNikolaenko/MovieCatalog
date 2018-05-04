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
    private var output: ListMoviesInteractorOutput!
    
    // MARK: - Initializers
    init(output: ListMoviesInteractorOutput) {
        super.init()
        self.output = output
    }
}

// MARK: - ListMoviesViewControllerOutput
extension ListInteractor: ListMoviesViewControllerOutput {
    func displayList() {
        movies.append(Movie(title: "aaaaaa", description: "djnjfdjkldfglkfjg"))
        movies.append(Movie(title: "ddddddd", description: "djnjfdjkldfglkfjg"))
        movies.append(Movie(title: "hhhhhhhh", description: "djnjfdjkldfglkfjg"))
        movies.append(Movie(title: "iiiiioooo", description: "djnjfdjkldfglkfjg"))
        movies.append(Movie(title: "pppppp", description: "djnjfdjkldfglkfjg"))
        movies.append(Movie(title: "wwwwww", description: "djnjfdjkldfglkfjg"))
        movies.append(Movie(title: "bbbbbb", description: "djnjfdjkldfglkfjg"))
        
        output.presentData(movies: movies)
    }
}
