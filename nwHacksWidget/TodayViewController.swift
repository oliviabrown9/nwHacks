//
//  TodayViewController.swift
//  nwHacksWidget
//
//  Created by Olivia Brown on 1/13/18.
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    
    @IBAction func floodButtonPressed(_ sender: Any) {
        let url: URL? = URL(string: "flood:")!
        
        if let appurl = url {
            self.extensionContext!.open(appurl,
                                        completionHandler: nil)
        }
    }
    @IBAction func medicalButtonPressed(_ sender: Any) {
        let url: URL? = URL(string: "medical:")!
        
        if let appurl = url {
            self.extensionContext!.open(appurl,
                                        completionHandler: nil)
        }
    }
    @IBAction func earthquakeButtonPressed(_ sender: Any) {
        let url: URL? = URL(string: "earthquake:")!
        
        if let appurl = url {
            self.extensionContext!.open(appurl,
                                        completionHandler: nil)
        }
    }
    @IBAction func crimeButtonPressed(_ sender: Any) {
        let url: URL? = URL(string: "crime:")!
        
        if let appurl = url {
            self.extensionContext!.open(appurl,
                                        completionHandler: nil)
        }
    }
    @IBAction func fireButtonPressed(_ sender: Any) {
        let url: URL? = URL(string: "fire:")!
        
        if let appurl = url {
            self.extensionContext!.open(appurl,
                                        completionHandler: nil)
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
