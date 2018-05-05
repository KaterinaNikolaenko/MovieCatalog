//
//  AddInteractor.swift
//  MovieCatalog
//
//  Created by Katerina on 05.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//
protocol DetailsInteractorOutput {
    func presentListOfData()
    func presentFailure()
}

import Foundation
import UIKit

class AddInteractor: NSObject, DetailsViewControllerOutput {
    
    private var output: DetailsInteractorOutput!
    private var worker: MovieWorker!
    
    // MARK: - Initializers
    init(output: DetailsInteractorOutput) {
        super.init()
        self.output = output
        self.worker = MovieWorker()
    }
    
    func saveData(title: String, genre: String, poster: UIImage, yearOfProduction: String, description: String) {
        let newMovie = Movie(title: title, genre: genre, poster: NSData(data: UIImagePNGRepresentation(poster)!), yearOfProduction: yearOfProduction, movieDescription: description)
        worker.saveMovie(movie: newMovie) { [weak self] (success) -> Void in
            self?.output.presentListOfData()
        }
    }
}
