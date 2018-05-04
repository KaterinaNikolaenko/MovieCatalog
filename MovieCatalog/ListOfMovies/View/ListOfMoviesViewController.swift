//
//  ViewController.swift
//  MovieCatalog
//
//  Created by Katerina on 04.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//
protocol ListMoviesViewControllerOutput: class {
    func displayList()
}

import UIKit

class ListOfMoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let cellReuseIdentifier = "Cell"
    private var movies: [Movie] = []
    private var output: ListMoviesViewControllerOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setup() {
        setupVIPInstances()
        setupNavigation()
        setupTableView()
    }
    
    private func setupVIPInstances() {
        let presenter = ListPresenter(output: self)
        let interactor = ListInteractor(output: presenter)
        output = interactor
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        output.displayList()
    }
    
    private func setupNavigation() {
        navigationItem.title = "My movies"
        //color
    }
}

// MARK: - UITableViewDataSource
extension ListOfMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UITableViewCell
        //        cell.imageView?.image
        cell.textLabel?.text = movies[indexPath.row].title
        cell.detailTextLabel?.text = movies[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - ListMoviePresenterOutput
extension ListOfMoviesViewController: ListMoviesPresenterOutput {
    func displayError() {
        
    }
    
    func displayData(movies: [Movie]) {
        self.movies = movies
        tableView.reloadData()
    }
}
