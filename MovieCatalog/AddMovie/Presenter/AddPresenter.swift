//
//  AddPresenter.swift
//  MovieCatalog
//
//  Created by Katerina on 05.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//
protocol DetailsPresenterOutput: class {
    func displayData()
    func displayError()
}

import Foundation

class AddPresenter: NSObject, DetailsInteractorOutput {
    
    private var output: DetailsPresenterOutput!
    
    // MARK: - Initializers
    init(output: DetailsPresenterOutput) {
        super.init()
        self.output = output
    }
    
    func presentListOfData() {
        output.displayData()
    }
    
    func presentFailure() {
        output.displayError()
    }
}
