//
//  ProfileRegisterModel.swift
//  CityCare
//
//  Created by Anisia Iova on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol ProfileRegisterModel {
    var id: String { get set }
    var fullName: String { get set }
    var email: String { get set }
    var latitude: Double { get set }
    var longitude: Double { get set }
    var radius: Int { get set }
    var age: Int { get set }
    var gender: Gender { get set }
    var password: String { get set }
    var profilePicture: UIImage? { get set }
}

class ProfileRegisterStubData : ProfileRegisterModel {
    var id = "79aeeb63-deb8-4c78-b9d1-5efa62f2ed19"
    var fullName = "Swifters bby"
    var email = "switers@gmail.com"
    var latitude = 45.748871
    var longitude = 45.748871
    var radius = 100
    var age = 22
    var gender = Gender.female
    var password = "12345"
    var profilePicture: UIImage? = nil
}

extension ProfileRegisterModel {
    func toJson() -> String {
        return "{ \"Id\": \"" + id + "\", \"FullName\": \"" + fullName + "\", \"Email\": \"" + email + "\", \"Latitude\": " + String(latitude) + ", \"Longitude\": " + String(longitude) + ", \"Radius\": " + String(radius) + ", \"Age\": " + String(age) + ", \"Gender\": " + String(gender.rawValue) + ", \"Password\": \"" + password + "\"}"
    }

    func updatedJson() -> String {
        return "{ \"Id\": \"" + id + "\", \"FullName\": \"" + fullName + "\", \"Latitude\": " + String(latitude) + ", \"Longitude\": " + String(longitude) + ", \"Radius\": " + String(radius) + ", \"Age\": " + String(age) + ", \"Gender\": " + String(gender.rawValue) + "}"
    }
}
