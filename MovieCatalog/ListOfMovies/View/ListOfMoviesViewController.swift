//
//  ViewController.swift
//  MovieCatalog
//
//  Created by Katerina on 04.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import UIKit

class ListOfMoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setup() {
        initialisation()
        setupNavigation()
        setupTableView()
    }
    
    private func initialisation() {
        
    }
    private func setupTableView() {
        
    }
    
    private func setupNavigation() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ListOfMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        cell.textLabel?.text = "aaaa"
        return cell
    }
}
