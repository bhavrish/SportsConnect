//
//  homeViewController.swift
//  sportsconnect
//
//  Created by Bhavesh Shah on 2/16/19.
//  Copyright © 2019 Bhavesh Shah. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseAuth
import FirebaseDatabase

class homeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var tableView: UITableView!

    var refActivities:DatabaseReference?
    
    var activityData = [activitiesModel]()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self;
        tableView.delegate = self;
        self.tableView.rowHeight = 100

        // set the firebase reference
        refActivities = Database.database().reference().child("activities");

        // retrieve the posts and listen for changes
        refActivities?.observe(DataEventType.value, with: { (snapshot) in
            
            for activities in snapshot.children.allObjects as! [DataSnapshot] {
                let actObject = activities.value as? [String: AnyObject]
                let actName = actObject?["activityName"] as! String?
                let actnumPlayers = actObject?["numPlayers"] as! String?
                let actDescription = actObject?["description"] as! String?
                let actId = actObject?["id"] as! String?
                
                
                let activity = activitiesModel(id: actId ,activityName: actName ,numPlayers: actnumPlayers ,description: actDescription)
                
                self.activityData.append(activity)
            }
            
            self.tableView.reloadData()
        })
        
        // Can use both when app is open and when app is in background.
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
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
        return activityData.count;
    }
    
    // Contents for each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! homeTableViewCell
        
        let activity: activitiesModel
        activity = activityData[indexPath.row]
        cell.activityname.text = activity.activityName
        cell.updateImages(name: cell.activityname.text!)
        return cell
    }
    
    @IBAction func addActivity(_ sender: Any) {
        self.performSegue(withIdentifier: "addActSegue", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cellClicked(_ sender: Any) {
        print("Aninda!!!")
    }
}
