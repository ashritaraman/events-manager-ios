//
//  TagViewController.swift
//  EventsManager
//
//  Created by Ethan Hu on 4/9/18.
//  Copyright © 2018 Jagger Brulato. All rights reserved.
//

import UIKit

class TagViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    
    //constants
    
    //datasource
    var tagName:String = ""
    var events:[Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
     * Sets up the tag view
     * - events: an events array that tha tag view should filter events from
     * - tag: the tag that should be displayed in this tag view
     */
    func setup(with events:[Event], for tag: String){
        //NAVIGATION STUFFS
        navigationItem.title = tag
        
        //assign dataSource
        self.events = events
        self.tagName = tag
        filterDataSource()
        
        
        
        //Tableview stuffs
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventsDiscoveryTableViewCell.self, forCellReuseIdentifier: EventsDiscoveryTableViewCell.identifer)
        tableView.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
    }
    
    /*
     * Filter the events datasource so that all it contains is events with self.tagName
     */
    private func filterDataSource(){
        var filteredEvents:[Event] = []
        for event in events {
            if event.eventTags.contains(tagName) {
                filteredEvents.append(event)
            }
        }
        events = filteredEvents
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsDiscoveryCell", for: indexPath) as! EventsDiscoveryTableViewCell
        // Configure the cell...
        cell.configure(event: events[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    /*
     segue to the selected eventsDetailController
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = EventDetailViewController()
        detailsViewController.configure(with: events[indexPath.row])
        navigationController?.pushViewController(detailsViewController, animated: true)
    }


}