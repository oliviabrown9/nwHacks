//
//  AppDelegate.swift
//  nwHacks
//
//  Created by Olivia Brown on 1/13/18.
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    var window: UIWindow?
    var ref: DatabaseReference!
    fileprivate let locationManager = CLLocationManager()
    
    var emergencyType: String?
    var mostRecentUserLocation: CLLocation?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        if Auth.auth().currentUser == nil {
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "AccountViewController")
            
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let message = url.scheme
        setUpLocationManager()
        if message == "fire" {
            createEmergency(emergencyType: "Fire")
        }
        else if message == "crime" {
            createEmergency(emergencyType: "Crime")
        }
        else if message == "earthquake" {
            createEmergency(emergencyType: "Earthquake")
        }
        else if message == "medical" {
            createEmergency(emergencyType: "Medical")
        }
        else if message == "flood" {
            createEmergency(emergencyType: "Flood")
        }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "StatusViewController")
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        return true
    }
    

    
    private func createEmergency(emergencyType: String) {
        ref = Database.database().reference()

        let phoneNumber = "3194273804"

        // find nearest dispatcher
        // get the dispatcherID
        let dispatcherID = "id" // temp

        // add emergency to firebase
        let newEmergencyRef = self.ref.child("Emergency").childByAutoId()

        newEmergencyRef.setValue(["dispatcherID":dispatcherID, "userID": Auth.auth().currentUser?.uid, "emergencyType": emergencyType])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            newEmergencyRef.child("location").setValue(["altitude": self.mostRecentUserLocation!.altitude, "latitude": self.mostRecentUserLocation!.coordinate.latitude, "longitude": self.mostRecentUserLocation!.coordinate.longitude])

        })

        // call 911
        let url = URL(string: "tel://\(phoneNumber)")
        UIApplication.shared.open(url!)
    }

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
