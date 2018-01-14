//
//  StatusViewController.swift
//  nwHacks
//
//  Created by Olivia Brown on 1/13/18.
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {
    
    @IBOutlet var avatarImageView: UIImageView!
    
    var emergencyType: String = "Emergency"

    @IBOutlet weak var emergencyTypeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImageView.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(StatusViewController.addPulse))
        tapGestureRecognizer.numberOfTapsRequired = 1
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        
        
    }
    
    
    @objc func addPulse(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 110, position: avatarImageView.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.blue.cgColor
        
        self.view.layer.insertSublayer(pulse, below: avatarImageView.layer)
        
    }
}
