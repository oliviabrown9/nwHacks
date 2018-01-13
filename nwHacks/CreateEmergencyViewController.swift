//
//  ViewController.swift
//  nwHacks
//
//  Created by Olivia Brown on 1/13/18.
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import CoreLocation

class CreateEmergencyViewController: UIViewController {
    
    fileprivate let locationManager = CLLocationManager()
    
    var mostRecentUserLocation: CLLocation? {
        didSet {
            guard let userLocation = mostRecentUserLocation else {
                return
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func createEmergency() {
        // find nearest call center
        // send user info to call center
        // call 911
    }

    @IBAction func fireButtonPressed(_ sender: Any) {
    }
    @IBAction func medicalButtonPressed(_ sender: Any) {
    }
    @IBAction func policeButtonPressed(_ sender: Any) {
    }
    @IBAction func carCrashButtonPressed(_ sender: Any) {
    }
}

// MARK: - CLLocationManagerDelegate
extension CreateEmergencyViewController: CLLocationManagerDelegate {
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mostRecentUserLocation = locations[0] as CLLocation
    }
    
}

