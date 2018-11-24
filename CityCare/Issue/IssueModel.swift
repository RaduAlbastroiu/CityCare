//
//  IssueModel.swift
//  CityCare
//
//  Created by Anisia Iova on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation
import UIKit

protocol IssueModel {
    var id: String { get set }
    var title: String { get set }
    var description: String { get set }
    var latitude: Double { get set }
    var longitude: Double { get set }
    var upVotes: Int { get set }
    var downVotes: Int { get set }
    var createdAt: Date { get set }
    var createdBy: String { get set }
    var creator: String { get set }
    var comments: [CommentModel] { get set }
    var images: [UIImage] { get set }
}

class IssueStubData : IssueModel {
    var id = "3605886a-93f9-4702-a381-10f0860bcb85"
    var title = "Issue Test"
    var description = "Description"
    var latitude = 45.0
    var longitude = 21.0
    var upVotes = 0
    var downVotes = 0
    var createdAt = Date.init(timeIntervalSince1970: 1542981984402)
    var createdBy = "adebef04-b1ee-462c-9da2-01182652e45d"
    var creator = "Deventure User"
    var comments = [CommentModel]()
    var images = [UIImage]()
}
