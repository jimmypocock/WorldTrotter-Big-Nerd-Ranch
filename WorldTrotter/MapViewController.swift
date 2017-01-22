//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Jimmy Pocock on 1/22/17.
//  Copyright © 2017 Jimmy Pocock. All rights reserved.
//
// Great resource for MapKit instruction
// https://www.raywenderlich.com/90971/introduction-mapkit-swift-tutorial
//
// Broken out map view controller
// https://github.com/lotfyahmed/MyLocation/blob/master/MyLocation/ViewController.swift
//
// Map example in Swift 8
// http://www.techotopia.com/index.php/A_Swift_Example_iOS_8_Location_Application
// http://www.techotopia.com/index.php/Working_with_Maps_on_iOS_8_with_Swift,_MapKit_and_the_MKMapView_Class
//
// Big Nerd Ranch Forum for Silver Challenge
// https://forums.bignerdranch.com/t/silver-challenge-users-location/8138/6
//
// Simple Map View
// https://iosdevcenters.blogspot.com/2016/09/simple-mapview-tutorial-in-swift-mapkit.html

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    var mapView: MKMapView!
    var locationManager = CLLocationManager()

    func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }

    let regionDelta: CLLocationDistance = 0.02
    func centerMapOnLocation(location: CLLocation) {

        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: regionDelta, longitudeDelta: regionDelta))

        mapView.setRegion(region, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let currentLocation: CLLocation = locations[locations.count - 1]
        
        print("Current Location: \(currentLocation)")
//        centerMapOnLocation(location: currentLocation)
    }

    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true

            locationManager.delegate = self
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func loadView() {
        // Create a map view
        mapView = MKMapView()

        // Set it as *the* view of this view controller
        view = mapView

        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0

        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)

        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor,
                                                                  constant: 8)

        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)

        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("MapViewController loaded its view.")

        checkLocationAuthorizationStatus()

        // 2)
        let location = CLLocationCoordinate2D(latitude: 23.0225,longitude: 72.5714)
        // 3)
        let span = MKCoordinateSpanMake(1, 1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)

        // 4)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "iOSDevCenter-Kirit Modi"
        annotation.subtitle = "Ahmedabad"
        mapView.addAnnotation(annotation)
    }
}
