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
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    
    var emergencyType: String = "Emergency"
    
    @IBOutlet weak var emergencyTypeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        var colors = [UIColor]()
        colors.append(UIColor(red: 225/255, green: 238/255, blue: 195/255, alpha: 1))
        colors.append(UIColor(red: 240/255, green: 80/255, blue: 83/255, alpha: 1))
        navBar.setGradientBackground(colors: colors)
        
        var timer = Timer()
        let delay = 1.0
        avatarImageView.isUserInteractionEnabled = true
        
        for _ in 0..<20 {

            timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(addPulse), userInfo: nil, repeats: true)
        }
    }
    
    
    @objc func addPulse(){
            let pulse = Pulsing(numberOfPulses: 1, radius: 250, position: avatarImageView.center)
            pulse.animationDuration = 0.8
            pulse.backgroundColor = UIColor.red.cgColor
            
            self.view.layer.insertSublayer(pulse, below: avatarImageView.layer)
        
        
    }
}
