//
//  LocationTableViewController.swift
//  WeatherDemo
//
//  Created by Simon Ng on 27/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {

    let locations = ["Paris, France", "Kyoto, Japan", "Sydney, Australia",
                     "Seattle, U.S.", "New York, U.S.", "Hong Kong, Hong Kong",
                     "Taipei, Taiwan", "London, U.K.", "Vancouver, Canada"]
    
    var selectedLocation = "" {
        didSet {
            let locations = selectedLocation.split { $0 == "," }.map { String($0) }
            
            selectedCity = locations[0]
            selectedCountry = locations[1].trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    private(set) var selectedCity = ""
    private(set) var selectedCountry = ""
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = locations[indexPath.row]
        cell.accessoryType = (locations[indexPath.row] == selectedLocation) ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        if let location = cell?.textLabel?.text {
            selectedLocation = location
        }
        
        tableView.reloadData()
    }
}
