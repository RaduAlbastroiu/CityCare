//
//  CommentModel.swift
//  CityCare
//
//  Created by Anisia Iova on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation

protocol CommentModel {
    var id: String { get set }
    var content: String { get set }
    var creator: String { get set }
    var createdAt: Date { get set }
    var edited: Int { get set }
}

class CommentStubData : CommentModel {
    var id = "14315d5a-dffd-410d-afe8-9003fd85aba5"
    var content = "swft"
    var creator = "Paul Boldijar"
    var createdAt = Date.init(timeIntervalSince1970: 1542996003941)
    var edited = -1
}

extension CommentModel {
    func toJson(issueId: String) -> String {
        return "{ \"Id\": \"" + id + "\", \"IssueId\": \"" + issueId + "\", \"Content\": \"" + content + "\", \"CreatedBy\": \"" + creator + "\"}"
    }
}
