//
//  ViewController.swift
//  MovieCatalog
//
//  Created by Katerina on 04.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//
protocol ListMoviesViewControllerOutput: class {
    func displayList()
    func findList(movies: [Movie], filterText: String)
}

import UIKit

class ListOfMoviesViewController: UIViewController {

    //UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let cellReuseIdentifier = "Cell"
    private var movies: [Movie] = []
    private var filterMovies: [Movie] = []
    private var isSearching = false
    
    private var output: ListMoviesViewControllerOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setup() {
        setupVIPInstances()
        setupNavigation()
        setupTableView()
        setupSearchBar()
    }
    
    private func setupVIPInstances() {
        let presenter = ListPresenter(output: self)
        let interactor = ListInteractor(output: presenter)
        output = interactor
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        if isSearching {
            output.findList(movies: movies, filterText: searchBar.text!)
        } else {
            output.displayList()
        }
    }
    
    private func setupNavigation() {
        navigationItem.title = "My movies"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addMovie))
        self.navigationController?.navigationBar.tintColor = UIColor.red
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.returnKeyType = .done
    }
    
    @objc func addMovie() {
        performSegue(withIdentifier: "Add", sender: nil)
    }
}

// MARK: - UITableViewDataSource
extension ListOfMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filterMovies.count
        } else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.imageView?.image = UIImage(named: "placeholder")
        if isSearching {
            cell.textLabel?.text = filterMovies[indexPath.row].title
            cell.detailTextLabel?.text = filterMovies[indexPath.row].movieDescription
            
            let dataImage = filterMovies[indexPath.row].poster
            DispatchQueue.global().async {
                let currentImage = dataImage != nil ? UIImage(data: dataImage! as Data) : UIImage(named: "placeholder")
                DispatchQueue.main.async {
                    cell.imageView?.image = currentImage
                }
            }
        } else {
            cell.textLabel?.text = movies[indexPath.row].title
            cell.detailTextLabel?.text = movies[indexPath.row].movieDescription
            
            let dataImage = movies[indexPath.row].poster
            DispatchQueue.global().async {
                let currentImage = dataImage != nil ? UIImage(data: dataImage! as Data) : UIImage(named: "placeholder")
                DispatchQueue.main.async {
                    cell.imageView?.image = currentImage
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Details", sender: isSearching ? filterMovies[indexPath.row] : movies[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Details"{
            if let nextViewController = segue.destination as? DetailsViewController{
                nextViewController.movie = sender as! Movie
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension ListOfMoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            output.displayList()
        } else {
            isSearching = true
            output.findList(movies: movies, filterText: searchBar.text!)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        output.displayList()
    }
}

// MARK: - ListMoviePresenterOutput
extension ListOfMoviesViewController: ListMoviesPresenterOutput {
    func displayError() {
        print("Error")
    }
    
    func displayData(movies: [Movie], filterMovies: [Movie]?) {
        self.movies = movies
        self.filterMovies = filterMovies ?? []
        tableView.reloadData()
    }
}
