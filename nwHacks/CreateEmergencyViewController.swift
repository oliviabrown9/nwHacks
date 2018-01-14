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
    
    var emergencyType: String?
    
    var mostRecentUserLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func createEmergency() {
        print()
        // find nearest call center
        // send user info to call center
        // call 911
    }

    @IBAction func fireButtonPressed(_ sender: Any) {
        emergencyType = "Fire"
        performSegue(withIdentifier: "toStatus", sender: self)
    }
    @IBAction func medicalButtonPressed(_ sender: Any) {
        emergencyType = "Medical"
        performSegue(withIdentifier: "toStatus", sender: self)
    }
    @IBAction func policeButtonPressed(_ sender: Any) {
        emergencyType = "Police"
        performSegue(withIdentifier: "toStatus", sender: self)
    }
    @IBAction func carCrashButtonPressed(_ sender: Any) {
        emergencyType = "Car Crash"
        performSegue(withIdentifier: "toStatus", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let statusViewController = segue.destination as? StatusViewController {
            if let emergency = emergencyType {
                statusViewController.emergencyType = emergency
            }
        }
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

