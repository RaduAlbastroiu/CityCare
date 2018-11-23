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
        
    }

    @IBAction func centerMap(_ sender: Any) {
        coreElements.mapController?.centerMapOnLocation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileSegue" {
            if let profileController = segue.destination as? ProfileViewController {
                profileController.profileModel = profileData
            }
        }
    }
}

