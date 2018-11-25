//
//  MapController.swift
//  CityCare
//
//  Created by Radu Albastroiu on 23/11/2018.
//  Copyright © 2018 Radu Albastroiu. All rights reserved.
//

import Foundation
import MapKit

class MapController: NSObject, MKMapViewDelegate {
    
    private var mkMapView: MKMapView
    private var shouldCenterMapOnLocation: Bool
    var currentLocation: CLLocation?
    var showIssues: Bool
    var coreElements: CoreElements?
    var viewController: ViewController
    
    init(mapView: MKMapView, viewController: ViewController) {
        self.showIssues = false
        self.mkMapView = mapView
        self.shouldCenterMapOnLocation = true
        mapView.showsUserLocation = true
        mapView.showsTraffic = true
        mapView.showsCompass = true
        mapView.showsScale = true
        self.viewController = viewController
        
        super.init()
        mapView.delegate = self
    }
    
    func addIssuesToMap(issues: [IssueModel]) {
        for issue in issues {
            let annotation = MKPointAnnotation()
            annotation.coordinate.latitude = issue.latitude
            annotation.coordinate.longitude = issue.longitude
            mkMapView.addAnnotation(annotation)
        }
    }
    
    func round2(_ value: Double, toNearest: Double) -> Double {
        return round(value / toNearest) * toNearest
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let selectedAnnotaion = view.annotation as? MKPointAnnotation {
            if let allIssues = coreElements?.allIssues {
                for issue in allIssues {
                    if(self.round2(issue.latitude, toNearest: 0.00001) == self.round2(selectedAnnotaion.coordinate.latitude, toNearest: 0.00001) &&
                        self.round2(issue.longitude, toNearest: 0.00001) == self.round2(selectedAnnotaion.coordinate.longitude, toNearest: 0.00001)) {
                        
                        self.viewController.performSegueToIssue(withIssue: issue)
                        break
                    }
                }
            }
        }
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

