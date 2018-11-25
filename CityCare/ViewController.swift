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
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.updateLoginMessage()
        self.getUserData()
        if let allIssues = coreElements.allIssues {
            coreElements.issueDataSource.update(with: allIssues)
        }
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
                
                DispatchQueue.main.async {
                    self.updateLoginMessage()
                }
            })
        } else {
            self.coreElements.authorizationFailed()
        }
    }
    
    @IBAction func mainButtonPress(_ sender: Any) {
        if(coreElements.isLoggedIn == false) {
            performSegue(withIdentifier: "LoginSegue", sender: nil)
        } else {
            performSegue(withIdentifier: "ReportSegue", sender: nil)
        }
    }
    
    func updateLoginMessage() {
        if(coreElements.isLoggedIn == false) {
            mainButton.setTitle("Login",for: .normal)
            mainLabel.text = "You must be logged in to report"
        } else {
            mainButton.setTitle("Report Issue",for: .normal)
            mainLabel.text = "Wanna report?"
        }
    }
    
    func getUserData() {
        if let email = UserDefaults.standard.string(forKey: coreElements.emailKey) {
            coreElements.networkManager?.getUserData(userEmail: email, completitionHandler: { (authorizationModel) in
                if authorizationModel.success {
                    self.coreElements.authorizationModel = authorizationModel
                }
            })
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
        } else if segue.identifier == "ReportSegue" {
            if let reportViewController = segue.destination as? ReportViewController {
                reportViewController.coreElements = self.coreElements
            }
        }
    }
}

