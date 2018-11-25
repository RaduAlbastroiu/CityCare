//
//  ProfileViewController.swift
//  CityCare
//
//  Created by Radu Albastroiu on 23/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var issuesTableView: UITableView!
    
    var coreElements: CoreElements?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameLabel.text = coreElements?.authorizationModel?.profileData.fullName
        
        if let personalIssues = coreElements?.authorizationModel?.profileData.issues {
            coreElements?.issueDataSource.update(with: personalIssues)
        }
 
        issuesTableView.delegate = self
        issuesTableView.dataSource = coreElements?.issueDataSource
        issuesTableView.reloadData()
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
    
    @IBAction func logOut(_ sender: Any) {
        coreElements?.logout()
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PersonalIssueSegue" {
            if let issueViewController = segue.destination as? IssueViewController,
                let indexPath = issuesTableView.indexPathForSelectedRow {
                issueViewController.coreElements = coreElements
                issueViewController.issueModel = coreElements?.issueDataSource.issue(at: indexPath)
            }
        }
    }
    
}
