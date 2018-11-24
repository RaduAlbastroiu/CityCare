//
//  ProfileModel.swift
//  CityCare
//
//  Created by Radu Albastroiu on 23/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation
import UIKit

enum Gender: String {
    case female
    case male
    case notSpecified
    
    func get() -> String {
        return self.rawValue
    }

    init?(value: Int) {
        if value == Int("0") {
            self = .male
        } else if value == Int("1") {
            self = .female
        } else {
            self = .notSpecified
        }
    }

}

protocol ProfileModel {
    var id: String { get set }
    var fullName: String { get set }
    var latitude: Double { get set }
    var longitude: Double { get set }
    var radius: Double { get set }
    var age: Int { get set }
    var gender: Gender { get set }
    var profilePicture: UIImage? { get set }
    var issues: [IssueModel] { get set }
}

class ProfileStubData : ProfileModel {
    var id = "adebef04-b1ee-462c-9da2-01182652e45d"
    var fullName = "Deventure User"
    var latitude = 22.0
    var longitude = 11144.0
    var radius = 0.0
    var age = 22
    var gender = Gender.female
    var profilePicture: UIImage? = nil
    var issues = [IssueModel]()
}
