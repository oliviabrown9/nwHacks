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
import MapKit

class EmergencyViewController: UIViewController {
    
    fileprivate let locationManager = CLLocationManager()
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var sosButton: UIImageView!
    
    var emergencyType: String?
    var mostRecentUserLocation: CLLocation?
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        var colors = [UIColor]()
        colors.append(UIColor(red: 225/255, green: 238/255, blue: 195/255, alpha: 1))
        colors.append(UIColor(red: 240/255, green: 80/255, blue: 83/255, alpha: 1))
        navBar.setGradientBackground(colors: colors)
        
        sosButton.layer.shadowColor = UIColor.black.cgColor
        sosButton.layer.shadowOpacity = 1
        sosButton.layer.shadowOffset = CGSize.zero
        sosButton.layer.shadowRadius = 10
        mapView.layer.cornerRadius = 10
        
        ref = Database.database().reference()
        setUpLocationManager()
    }
    
    private func createEmergency(emergencyType: String) {
        
        // add emergency to firebase
        let newEmergencyRef = self.ref.child("Emergency").childByAutoId()
        let newEmergencyKey = newEmergencyRef.key
        let dispatcherID = getRequest(params: ["emergencyID":newEmergencyKey])
        
        newEmergencyRef.setValue(["dispatcherID":dispatcherID, "userID": Auth.auth().currentUser?.uid, "emergencyType": emergencyType])
        newEmergencyRef.child("location").setValue(["altitude": mostRecentUserLocation!.altitude, "latitude": mostRecentUserLocation!.coordinate.latitude, "longitude": mostRecentUserLocation!.coordinate.longitude])
        
        messageContact(params: ["phoneNumber": "14256268741", "name": "Olivia Brown", "emergency": emergencyType])
        }
    
    private func messageContact(params: [String:String]) {
        
        let urlComp = NSURLComponents(string: "https://bchong.lib.id/playground/messaging/")!
        var items = [URLQueryItem]()
        
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        items = items.filter{!$0.name.isEmpty}
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
        })
        task.resume()
        
    }
    
    func getRequest(params: [String:String]) -> String {
        var myResult: String = ""
        
        let urlComp = NSURLComponents(string: "https://bchong.lib.id/playground/dispatcher_matcher/")!
        var items = [URLQueryItem]()
        
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        items = items.filter{!$0.name.isEmpty}
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let data = data, let stringResponse = String(data: data, encoding: .utf8) {
                myResult = stringResponse
            }
        })
        task.resume()
        
        return myResult
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
    @IBAction func earthquakeButtonPressed(_ sender: Any) {
        emergencyType = "Earthquake"
        createEmergency(emergencyType: emergencyType!)
        performSegue(withIdentifier: "toStatus", sender: self)
    }
    @IBAction func floodButtonPressed(_ sender: Any) {
        emergencyType = "Flood"
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
        let center = CLLocationCoordinate2D(latitude: (mostRecentUserLocation?.coordinate.latitude)!, longitude: (mostRecentUserLocation?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }
}
extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 0, y: 1)
    }
    
    func creatGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
}

extension UINavigationBar {
    
    func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += 20
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        setBackgroundImage(gradientLayer.creatGradientImage(), for: UIBarMetrics.default)
    }
}

