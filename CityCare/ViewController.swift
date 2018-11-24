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
        
        let networkManager = NetworkManager()
        coreElements.networkManager = networkManager
        networkManager.coreElements = coreElements
        
        networkManager.getAllIssues()
        
        checkAuthorization()
    }
    
    func checkAuthorization() {
        if let email = UserDefaults.standard.string(forKey: coreElements.emailKey),
            let tokenType = UserDefaults.standard.string(forKey: coreElements.tokenTypeKey),
            let accessToken = UserDefaults.standard.string(forKey: coreElements.accessTokenKey) {

            coreElements.networkManager?.isAuthorized(userEmail: email, tokenType: tokenType, accessToken: accessToken, completitionHandler: { authorizationModel in
                if authorizationModel.success == false {
                    self.coreElements.authorizationFailed()
                } else {
                    self.coreElements.authorizationSucceded(authorization: authorizationModel)
                }
            })
        } else {
            self.coreElements.authorizationFailed()
        }
    }
    
    func registerUser(registerModel: ProfileRegisterModel) {
        coreElements.networkManager?.registerUser(registerModel: ProfileRegisterStubData(), completitionHandler: { data in
            self.coreElements.authorizationModel = data
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

