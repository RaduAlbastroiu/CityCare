//
//  IssueViewController.swift
//  CityCare
//
//  Created by Radu Albastroiu on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit

class IssueViewController: UIViewController, UITableViewDelegate  {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var issueTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var upVotesLabel: UILabel!
    @IBOutlet weak var downVotesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var coreElements: CoreElements?
    var issueModel: IssueModel?
    var commentsDataSource = CommentsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        if let comments = issueModel?.comments {
            commentsDataSource.update(with: comments)
        }
        tableView.dataSource = commentsDataSource

        if let issueModel = issueModel {
            let date = issueModel.createdAt
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "HH:mm dd-MM-yyyy" //Specify your format that you want
            let strDate = dateFormatter.string(from: date)
            dateLabel.text = strDate
            
            issueTitleLabel.text = issueModel.title
            descriptionLabel.text = issueModel.description
            upVotesLabel.text = String(issueModel.upVotes)
            downVotesLabel.text = String(issueModel.downVotes)

        }
    }
    

    @IBAction func addComment(_ sender: Any) {
        print("Add comment")
    }
    
}
