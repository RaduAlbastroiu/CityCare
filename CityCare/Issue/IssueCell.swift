//
//  IssueCell.swift
//  CityCare
//
//  Created by Radu Albastroiu on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit

class IssueCell: UITableViewCell {
    
    @IBOutlet weak var issueTitleLabel: UILabel!
    @IBOutlet weak var issueDescriptionLabel: UILabel!
    
    static var reuseIdentifier = "IssueCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with issueModel: IssueModel) {
        issueTitleLabel.text = issueModel.title
        issueDescriptionLabel.text = issueModel.description
    }
    
}
