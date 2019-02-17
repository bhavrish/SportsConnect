//
//  activityViewController.swift
//  sportsconnect
//
//  Created by Bhavesh Shah on 2/16/19.
//  Copyright © 2019 Bhavesh Shah. All rights reserved.
//

import UIKit
import FirebaseDatabase

class activityViewController: UIViewController {

    var refActivities:DatabaseReference?
    
    @IBOutlet weak var activityLabel: UITextField!
    @IBOutlet weak var playersLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //top of the tree, activity is the name of the table
        refActivities = Database.database().reference().child("activities");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onUpdate(_ sender: Any) {
        // key for child
        let key = refActivities?.childByAutoId().key
        
        //building child
        let activity = ["id":key,"activityName": activityLabel.text! as String,"numPlayers": playersLabel.text! as String,"description": descriptionLabel.text! as String]
        
        //pushes child to parent
        refActivities?.child(key!).setValue(activity)
        
    }
    
}
