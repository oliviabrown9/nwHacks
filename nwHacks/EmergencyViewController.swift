//
//  ViewController.swift
//  nwHacks
//
//  Created by Olivia Brown on 1/13/18.
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class EmergencyViewController: UIViewController {
    
    fileprivate let locationManager = CLLocationManager()
    
    var emergencyType: String?
    var mostRecentUserLocation: CLLocation?
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        setUpLocationManager()
    }
    
    private func createEmergency(emergencyType: String) {
        
        let phoneNumber = "3194273804"
        
        // find nearest dispatcher
        // get the dispatcherID
        let dispatcherID = "id" // temp
        
        // add emergency to firebase
        let newEmergencyRef = self.ref.child("Emergency").childByAutoId()
        
        newEmergencyRef.setValue(["dispatcherID":dispatcherID, "userID": Auth.auth().currentUser?.uid, "emergencyType": emergencyType])
        newEmergencyRef.child("location").setValue(["altitude": mostRecentUserLocation!.altitude, "latitude": mostRecentUserLocation!.coordinate.latitude, "longitude": mostRecentUserLocation!.coordinate.longitude])
        
        // call 911
        let url = URL(string: "tel://\(phoneNumber)")
        UIApplication.shared.open(url!)
    }
    
    @IBAction func fireButtonPressed(_ sender: Any) {
        emergencyType = "Fire"
        createEmergency(emergencyType: emergencyType!)
        performSegue(withIdentifier: "toStatus", sender: self)
    }
    @IBAction func medicalButtonPressed(_ sender: Any) {
        emergencyType = "Medical"
        createEmergency(emergencyType: emergencyType!)
        performSegue(withIdentifier: "toStatus", sender: self)
    }
    @IBAction func policeButtonPressed(_ sender: Any) {
        emergencyType = "Police"
        createEmergency(emergencyType: emergencyType!)
        performSegue(withIdentifier: "toStatus", sender: self)
    }
    @IBAction func carCrashButtonPressed(_ sender: Any) {
        emergencyType = "Car Crash"
        createEmergency(emergencyType: emergencyType!)
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
extension EmergencyViewController: CLLocationManagerDelegate {
    
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

