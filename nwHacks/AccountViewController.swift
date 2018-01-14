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
        self.navigationController?.navigationBar.isHidden = true
        ref = Database.database().reference()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func addInfoButtonPressed(_ sender: Any) {
        
        if (firstName.text == nil || lastName.text == nil || age.text == nil) {
            let alert = UIAlertController(title: "Alert", message: "Name and age are required", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let email = "\(firstName.text!)\(lastName.text!)@gmail.com"
            let password = "\(firstName.text!)\(age.text!)\(lastName.text!)"
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                
                // Check that user isn't NIL
                if let u = user {
                    //User is found, goto home screen
                    print("success")
                    
                    let user = Auth.auth().currentUser
                    
                    let bloodTypeText = self.bloodType.text ?? ""
                    let heightText = self.height.text ?? ""
                    let weightText = self.weight.text ?? ""
                    let hairColorText = self.hairColor.text ?? ""
                    let eyeColorText = self.eyeColor.text ?? ""
                    let emergencyContactText = self.emergencyContact.text ?? ""
                    
                    
                    self.ref.child("Users").child(user!.uid).setValue(["firstName": self.firstName.text!, "lastName": self.lastName.text!, "age": self.age.text!, "bloodType": bloodTypeText, "height": heightText, "weight": weightText, "hairColor": hairColorText, "eyeColor": eyeColorText, "emergencyContact": emergencyContactText])
                    self.performSegue(withIdentifier: "toCreate", sender: self)
                }
                else {
                    print(":(")
                    if let error = error {
                        print(error)
                    }
                }
            })
        }
    }
}
