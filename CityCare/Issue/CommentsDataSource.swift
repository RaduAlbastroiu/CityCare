//
//  CommentsDataSource.swift
//  CityCare
//
//  Created by Radu Albastroiu on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit

class CommentsDataSource: NSObject, UITableViewDataSource {
    
    private var data = [CommentModel]()
    
    override init() {
        super.init()
    }
    
    func update(with comments: [CommentModel]) {
        data = comments
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let commentCell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseIdentifier, for: indexPath) as! CommentCell
        
        let commentModel = data[indexPath.row]
        commentCell.configure(with: commentModel)
        
        return commentCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // MARK: - Helper
    
    func comment(at indexPath: IndexPath) -> CommentModel {
        return data[indexPath.row]
    }
}
