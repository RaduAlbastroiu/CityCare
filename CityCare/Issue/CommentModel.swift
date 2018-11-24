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
    var id = "9d658973-ebb6-48e6-bd75-7f1d2327376a"
    var content = "Hi loosers"
    var creator = "Paul Boldijar"
    var createdAt = Date.init(timeIntervalSince1970: 1542996003941)
    var edited = -1
}
