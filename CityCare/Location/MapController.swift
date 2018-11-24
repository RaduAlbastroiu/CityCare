//
//  MapController.swift
//  CityCare
//
//  Created by Radu Albastroiu on 23/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation
import MapKit

class MapController {
    
    private var mkMapView: MKMapView
    private var shouldCenterMapOnLocation: Bool
    var currentLocation: CLLocation?

    var showIssues: Bool
    
    init(mapView: MKMapView) {
        self.showIssues = false
        self.mkMapView = mapView
        self.shouldCenterMapOnLocation = true
        mapView.showsUserLocation = true
        mapView.showsTraffic = true
        mapView.showsCompass = true
        mapView.showsScale = true
    }
    
    func centerMapOnLocation() {
        centerMapOn(location: self.currentLocation!, withRadius: 750)
    }
    
    private func centerMapOn(location: CLLocation, withRadius radius: Double) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mkMapView.setRegion(coordinateRegion, animated: true)
    }
}

extension MapController: LocationManagerDelegate {
    func locationUpdated(didUpdateLocations locations: [CLLocation]) {
        if(shouldCenterMapOnLocation) {
            if(locations.count > 0) {
                centerMapOn(location: locations[0], withRadius: 1000)
                shouldCenterMapOnLocation = false
            }
        }
        currentLocation = locations[0]
    }
}

