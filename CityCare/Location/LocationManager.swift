//
//  LocationManager.swift
//  CityCare
//
//  Created by Radu Albastroiu on 23/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    func locationUpdated(didUpdateLocations locations: [CLLocation])
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    var delegate: LocationManagerDelegate?
    
    var currentLocation: CLLocation?
    
    override init() {
        super.init()
        
        // ios delegate for CLLocationManager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if(locations.count > 0) {
            currentLocation = locations[0]
            if let delegate = delegate {
                delegate.locationUpdated(didUpdateLocations: locations)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
