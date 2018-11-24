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
    
    func authorizationFailed() {
        self.authorizationModel = AuthorizationStubData()
        self.isLoggedIn = false
        UserDefaults.standard.set(nil, forKey: self.accessTokenKey)
        UserDefaults.standard.set(nil, forKey: self.tokenTypeKey)
        UserDefaults.standard.set(nil, forKey: self.emailKey)
    }
    func authorizationSucceded(authorization: AuthorizationModel) {
        self.authorizationModel = authorization
        self.isLoggedIn = true
    }
    
    func loginFailed() {
        self.authorizationModel?.profileData = ProfileStubData()
        self.authorizationModel?.success = false
        self.authorizationModel?.statusCode = -1
        self.isLoggedIn = false
    }
    
    func loginSucceded(tokenModel: TokenModel) {
        UserDefaults.standard.set(tokenModel.accessToken, forKey: self.accessTokenKey)
        UserDefaults.standard.set(tokenModel.tokenType, forKey: self.tokenTypeKey)
        UserDefaults.standard.set(tokenModel.userName, forKey: self.emailKey)

        self.authorizationModel?.profileData = tokenModel.userData
        self.authorizationModel?.success = true
        self.authorizationModel?.statusCode = 0
        self.isLoggedIn = true
    }
    
    func logout() {
        UserDefaults.standard.set(nil, forKey: self.accessTokenKey)
        UserDefaults.standard.set(nil, forKey: self.tokenTypeKey)
        UserDefaults.standard.set(nil, forKey: self.emailKey)
        
        self.authorizationModel?.profileData = ProfileStubData()
        self.authorizationModel?.success = false
        self.authorizationModel?.statusCode = -1
        self.isLoggedIn = false
    }
}
