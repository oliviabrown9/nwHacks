//
//  AccountViewController.swift
//  nwHacks
//
//  Created by Olivia Brown on 1/13/18.
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


// Dispatchers, Users, Emergency
class AccountViewController: UIViewController {
    
    var ref: DatabaseReference!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var bloodType: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var hairColor: UITextField!
    @IBOutlet weak var eyeColor: UITextField!
    @IBOutlet weak var emergencyContact: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    @IBAction func addInfoButtonPressed(_ sender: Any) {
        
        if (firstName.text == nil || lastName.text == nil || age.text == nil) {
            let alert = UIAlertController(title: "Alert", message: "Name and age are required", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            
            Auth.auth().createUser(withEmail: "\(firstName)\(lastName)@email.com", password: "\(firstName)\(age)\(lastName) ") { (user, error) in
            }
            
            let user = Auth.auth().currentUser
            print("\(user!) created")
            
            self.ref.child("users").child(user!.uid).setValue(["firstName": firstName.text!])
            self.ref.child("users").child(user!.uid).setValue(["lastName": lastName.text!])
            self.ref.child("users").child(user!.uid).setValue(["age": age.text!])
            
            if let bloodTypeText = bloodType.text {
                self.ref.child("users").child(user!.uid).setValue(["bloodType": bloodTypeText])
            }
            else {
                self.ref.child("users").child(user!.uid).setValue(["bloodType": ""])
            }
            
            if let heightText = height.text {
                self.ref.child("users").child(user!.uid).setValue(["height": heightText])
            }
            else {
                self.ref.child("users").child(user!.uid).setValue(["height": ""])
            }
            
            if let weightText = weight.text {
                self.ref.child("users").child(user!.uid).setValue(["weight": weightText])
            }
            else {
                self.ref.child("users").child(user!.uid).setValue(["weight": ""])
            }
            
            if let hairColorText = hairColor.text {
                self.ref.child("users").child(user!.uid).setValue(["hairColor": hairColorText])
            }
            else {
                self.ref.child("users").child(user!.uid).setValue(["hairColor": ""])
            }
            
            if let eyeColorText = eyeColor.text {
                self.ref.child("users").child(user!.uid).setValue(["eyeColor": eyeColorText])
            }
            else {
                self.ref.child("users").child(user!.uid).setValue(["eyeColor": ""])
            }
            
            if let emergencyContactText = emergencyContact.text {
                self.ref.child("users").child(user!.uid).setValue(["emergencyContact": emergencyContactText])
            }
            else {
                self.ref.child("users").child(user!.uid).setValue(["emergencyContact": ""])
            }
        }
    }
}
