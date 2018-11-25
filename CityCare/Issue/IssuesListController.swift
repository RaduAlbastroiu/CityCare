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

    @IBAction func goBack(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        view.layer.add(transition, forKey: "leftoright")
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "IssueSegue" {
            if let issueViewController = segue.destination as? IssueViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                issueViewController.coreElements = coreElements
                issueViewController.issueModel = coreElements?.issueDataSource.issue(at: indexPath)
                issueViewController.showButtons = false
            }
        }
    }

}

extension IssuesListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
        
            var issueListWithName = [IssueModel]()
            if let coreElements = coreElements, let issues = coreElements.allIssues {
                for issue in issues {
                    if issue.title.lowercased().range(of: searchText.lowercased()) != nil {
                        issueListWithName.append(issue)
                    } else if issue.description.lowercased().range(of: searchText.lowercased()) != nil {
                        issueListWithName.append(issue)
                    }
                }
            }
            
            coreElements?.issueDataSource.update(with: issueListWithName)
            self.tableView.reloadData()
        }
    }
}

