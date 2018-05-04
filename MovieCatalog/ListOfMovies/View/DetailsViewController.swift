//
//  DetailsViewController.swift
//  MovieCatalog
//
//  Created by Katerina on 05.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    //UI
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var yearOfProductionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func config() {
        movieImageView.image = UIImage(named: "placeholder")
        titleLabel.text = movie.title
        genreLabel.text = movie.genre 
        //        yearOfProductionLabel.text = movie.
        descriptionTextView.text = movie.description
    }
}
