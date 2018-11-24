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
    
    var mapController: MapController?
    var locationManager: LocationManager?
    var networkManager: NetworkManager?
    
    var allIssues: [IssueModel]?
    var issueDataSource = IssueDataSource()
    
    var profileData: ProfileModel?
    var authorizationModel: AuthorizationModel?
}
