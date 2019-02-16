//
//  homeViewController.swift
//  sportsconnect
//
//  Created by Bhavesh Shah on 2/16/19.
//  Copyright © 2019 Bhavesh Shah. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class homeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var activities = [String]()

        
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self;
        tableView.delegate = self;
        
        // Can use both when app is open and when app is in background.
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    // code for fetching data from database
    func fetchPostData() {
        let query = PFQuery(className: "Activities")
        query.order(byDescending: "name")
        query.findObjectsInBackground { (posts, error) in
            if error == nil {
                for post in posts! {
                    self.activities.append(post["acitivityName"] as! String)
                }
                
                self.tableView.reloadData()
            }
                
            else {
                print(error)
            }
        }
    }
    
    // authorization code for location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    // Disabled PopUp code
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled", message: "In order to get events near you , we need your location.", preferredStyle: . alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count;
    }
    
    // Contents for each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! homeTableViewCell
        cell.activityname.text = activities[indexPath.row]
        return cell
    }
    
    @IBAction func addActivity(_ sender: Any) {
        self.performSegue(withIdentifier: "addActSegue", sender: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
