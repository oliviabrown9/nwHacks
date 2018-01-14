//
//  StatusViewController.swift
//  nwHacks
//
//  Created by Olivia Brown on 1/13/18.
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {
    
    var emergencyType: String = "this shouldn't be shown"

    @IBOutlet weak var emergencyTypeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emergencyTypeLabel.text = emergencyType
    }
}
