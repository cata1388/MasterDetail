//
//  MapViewController.swift
//  MasterDetailApp
//
//  Created by Catalina Sánchez on 6/27/18.
//  Copyright © 2018 Catalina Sánchez. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    var productLocation: Location? = nil
    
    // MARK: Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

// MARK: Extensions

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var center: CLLocationCoordinate2D
        let region: MKCoordinateRegion
        
        guard let userLocation = locations.last else { return }
        center = CLLocationCoordinate2D(latitude: (userLocation.coordinate.latitude), longitude: (userLocation.coordinate.longitude))
        
        if self.productLocation != nil {
            center = CLLocationCoordinate2DMake((self.productLocation?.latitude)!, (self.productLocation?.longitude)!)
        }
        
        region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
