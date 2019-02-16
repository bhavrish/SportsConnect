//
//  signupViewController.swift
//  sportsconnect
//
//  Created by Bhavesh Shah on 2/16/19.
//  Copyright © 2019 Bhavesh Shah. All rights reserved.
//

import UIKit
import Parse

class signupViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var genderSegControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onRegister(_ sender: Any) {
        
        // initializes a new Parse user object
        let newUser = PFUser()
        
        // sets user properties
        newUser["name"] = nameField.text
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        if genderSegControl.selectedSegmentIndex==0 {
            newUser["gender"] = "male"
        }
        else if genderSegControl.selectedSegmentIndex==1 {
            newUser["gender"] = "female"
        }
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User created")
                
                self.performSegue(withIdentifier: "mainSegue2", sender: nil)
            }
            
        }
    }
    
}
