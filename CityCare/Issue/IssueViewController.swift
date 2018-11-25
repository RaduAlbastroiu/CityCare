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
    var showButtons = false

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
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addComment(_ sender: Any) {
        performSegue(withIdentifier: "AddCommentSegue", sender: nil)
    }

    @IBAction func deleteComment(_ sender: Any) {
        let disableMyButton = sender as? UIButton
        disableMyButton!.isEnabled = showButtons
        // should delete
        var id = ""
        if let indexPath = tableView.indexPathForSelectedRow {
            id = commentsDataSource.comment(at: indexPath).id
        }
        let tokenType = UserDefaults.standard.string(forKey: (coreElements?.tokenTypeKey)!)
        let accessToken = UserDefaults.standard.string(forKey: (coreElements?.accessTokenKey)!)
        coreElements?.networkManager?.deleteComment(id: id, tokenType: tokenType!, accessToken: accessToken!, completitionHandler: { (succeded) in
                print(succeded)
            })
    }

    @IBAction func editCommentButton(_ sender: Any) {
        let disableMyButton = sender as? UIButton
        disableMyButton!.isEnabled = showButtons
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddCommentSegue" {
            if let addCommentController = segue.destination as? AddCommentViewController {
                addCommentController.coreElements = coreElements
                addCommentController.issueId = (issueModel?.id)!
            }
        }
    }
}
