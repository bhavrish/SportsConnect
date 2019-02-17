//
//  conditionsViewController.swift
//  sportsconnect
//
//  Created by Bhavesh Shah on 2/16/19.
//  Copyright © 2019 Bhavesh Shah. All rights reserved.
//

import UIKit

class conditionsViewController: UIViewController {

    
    @IBOutlet weak var milesSelector: UISegmentedControl!
    @IBOutlet weak var genderSelector: UISegmentedControl!
    @IBOutlet weak var dateSelector: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventSegue" {
            let destinationVC = segue.destination as! eventsViewController
        }
    }

}
