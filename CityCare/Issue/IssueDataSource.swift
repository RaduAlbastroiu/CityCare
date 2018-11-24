//
//  IssueDataSource.swift
//  CityCare
//
//  Created by Radu Albastroiu on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation
import UIKit

class IssueDataSource: NSObject, UITableViewDataSource {
    
    private var data = [IssueModel]()
    
    override init() {
        super.init()
    }
    
    func update(with issues: [IssueModel]) {
        data = issues
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let issueCell = tableView.dequeueReusableCell(withIdentifier: IssueCell.reuseIdentifier, for: indexPath) as! IssueCell
        
        let issueModel = data[indexPath.row]
        issueCell.configure(with: issueModel)
        issueCell.accessoryType = .disclosureIndicator
        
        return issueCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // MARK: - Helper
    
    func issue(at indexPath: IndexPath) -> IssueModel {
        return data[indexPath.row]
    }
}
