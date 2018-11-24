//
//  StatsViewController.swift
//  CityCare
//
//  Created by Radu Albastroiu on 23/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit

class IssuesListController: UITableViewController {

    var coreElements: CoreElements?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        
        tableView.dataSource = coreElements?.issueDataSource
    }

    func dismissListController() {
        dismiss(animated: true, completion: nil)
    }

}

extension IssuesListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        // try another request
    }
}

