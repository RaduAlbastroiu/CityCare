//
//  ViewController.swift
//  CityCare
//
//  Created by Radu Albastroiu on 23/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var coreElements = CoreElements()
    var locationManager = LocationManager()
    var profileData = ProfileStubData()
    var issueData = IssueStubData()

    @IBOutlet weak var reportIssueButton: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var centerMapButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        reportIssueButton.layer.cornerRadius = 10
        reportIssueButton.clipsToBounds = true
    
        centerMapButton.layer.cornerRadius = 25
        centerMapButton.clipsToBounds = true
        
        coreElements.mapController = MapController(mapView: mapView)
        coreElements.locationManager = locationManager
        coreElements.locationManager?.delegate = coreElements.mapController
        
        var networkManager = NetworkManager()
        coreElements.networkManager = networkManager

        getAllIssues()
        
        checkAuthorization()
    }
    
    func loginUser(email: String, password: String) {
        coreElements.networkManager?.loginUser(email: email, password: password, completitionHandler: { tokenData in

            // set in local storage
            UserDefaults.standard.set(tokenData.accessToken, forKey: self.coreElements.accessTokenKey)
            UserDefaults.standard.set(tokenData.tokenType, forKey: self.coreElements.tokenTypeKey)
            UserDefaults.standard.set(tokenData.userName, forKey: self.coreElements.emailKey)      // username IS the email
        })
    }
    
    func checkAuthorization() {

        if let email = UserDefaults.standard.string(forKey: "email"),
            let tokenType = UserDefaults.standard.string(forKey: "tokenType"),
            let accessToken = UserDefaults.standard.string(forKey: "accessToken") {

            isAuthorized(email: email, tokenType: tokenType, accessToken: accessToken)
        } else {
            self.coreElements.authorizationModel = nil
            self.coreElements.isLoggedIn = false
        }
    }
    
    func getAllIssues() {
        coreElements.networkManager?.getIssues(completitionHandler: { issues in
            if issues.count > 0 {
                self.coreElements.allIssues = issues
                self.coreElements.issueDataSource.update(with: issues)
            }
        })
    }
    
    func getProfileData(email: String) {
        coreElements.networkManager?.getUserData(userEmail: email, completitionHandler: { data in
            self.coreElements.authorizationModel = data
        })
    }
    
    func registerUser(registerModel: ProfileRegisterModel) {
        coreElements.networkManager?.registerUser(registerModel: ProfileRegisterStubData(), completitionHandler: { data in
            self.coreElements.authorizationModel = data
        })
    }
    
    func isAuthorized(email:String, tokenType: String, accessToken: String) {
        
        coreElements.networkManager?.isAuthorized(userEmail: email, tokenType: tokenType, accessToken: accessToken, completitionHandler: { data in
            if data.success == false {
                self.coreElements.authorizationModel = nil
                self.coreElements.isLoggedIn = false
            } else {
                self.coreElements.authorizationModel = data
                self.coreElements.isLoggedIn = true
            }
        })
    }

    @IBAction func centerMap(_ sender: Any) {
        coreElements.mapController?.centerMapOnLocation()
    }

    @IBAction func profileButtonPress(_ sender: Any) {
        if coreElements.isLoggedIn == true {
            performSegue(withIdentifier: "ProfileSegue", sender: nil)
        } else {
            performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileSegue" {
            if let profileController = segue.destination as? ProfileViewController {
                profileController.coreElements = coreElements
            }
        } else if segue.identifier == "IssueListSegue" {
            if let issueNavigationController = segue.destination as? UINavigationController,
                let issueListController = issueNavigationController.topViewController as? IssuesListController {
                
                issueListController.coreElements = coreElements
            }
        } else if segue.identifier == "LoginSegue" {
            if let loginViewController = segue.destination as? LoginViewController {
                loginViewController.coreElements = self.coreElements
            }
        }
    }
}

