//
//  eventsViewController.swift
//  sportsconnect
//
//  Created by Bhavesh Shah on 2/16/19.
//  Copyright © 2019 Bhavesh Shah. All rights reserved.
//

import UIKit

class eventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var events:[[String:Any]] = [] //Array of Dictionaries: All the events
    
    
    /*  keys:
        "name"
        "date"
        "location"
        "people"
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        eventsFiller()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        self.tableView.rowHeight = 125
        
    }
    
    //filling events (example)
    func eventsFiller() {
        events = [
            [
                "Name":"Soccer Game",
                "Date":"02/17/19",
                "location":"Jamaica, NewYork",
                "Peolple":20
            ]
        ]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! eventsTableViewCell
        let first_event = events[0]
        cell.eventNameLabel.text = first_event["Name"] as? String
        cell.eventNameLabel.text = "hello"
        
        return cell
    }

}
