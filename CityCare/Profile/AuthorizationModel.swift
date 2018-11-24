//
//  AuthorizationModel.swift
//  CityCare
//
//  Created by Anisia Iova on 24/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation

protocol AuthorizationModel {
    var profileData: ProfileModel { get set }
    var success: Bool { get set }
    var statusCode: Int { get set }
    
}

class AuthorizationStubData : AuthorizationModel {
    var profileData: ProfileModel = ProfileStubData()
    var success = false
    var statusCode = -1
}
