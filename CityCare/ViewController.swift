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
        coreElements.networkManager?.registerUser(registerModel: ProfileRegisterStubData(), completitionHandler: { data in
            self.coreElements.authorizationModel = data
            self.coreElements.profileData = data.profileData // TODO: see what to do about this
        })
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
            self.coreElements.profileData = data.profileData  // TODO: see what to do about this
        })
    }
    
    func isAuthorized(email:String, tokenType: String, accessToken: String) {
        coreElements.networkManager?.isAuthorized(userEmail: email, tokenType: tokenType, accessToken: accessToken, completitionHandler: { data in
            self.coreElements.authorizationModel = data
            self.coreElements.profileData = data.profileData // TODO: see what to do about this
        })
    }

    @IBAction func centerMap(_ sender: Any) {
        coreElements.mapController?.centerMapOnLocation()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileSegue" {
            if let profileController = segue.destination as? ProfileViewController {
                profileController.coreElements = coreElements
                profileController.profileModel = profileData
            }
        } else if segue.identifier == "IssueListSegue" {
            if let issueNavigationController = segue.destination as? UINavigationController,
                let issueListController = issueNavigationController.topViewController as? IssuesListController {
                
                issueListController.coreElements = coreElements
            }
        }
    }
}

