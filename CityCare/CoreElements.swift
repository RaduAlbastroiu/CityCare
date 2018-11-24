//
//  CoreElements.swift
//  CityCare
//
//  Created by Radu Albastroiu on 23/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation
import MapKit

class CoreElements {
    
    let accessTokenKey = "accessToken"
    let tokenTypeKey = "tokenType"
    let emailKey = "email"
    
    var mapController: MapController?
    var locationManager: LocationManager?
    var networkManager: NetworkManager?
    
    var allIssues: [IssueModel]?
    var issueDataSource = IssueDataSource()
    
    var authorizationModel: AuthorizationModel?
    
    var isLoggedIn = false
}
