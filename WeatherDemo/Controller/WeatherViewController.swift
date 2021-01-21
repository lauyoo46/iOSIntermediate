//
//  WeatherViewController.swift
//  WeatherDemo
//
//  Created by Simon Ng on 27/10/2016.
//  Updated by Simon Ng on 7/12/2017.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import WeatherInfoKit

class WeatherViewController: UIViewController {

    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    public var city = "Milano"
    public var country = "Italy"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherLabel.text = ""
        temperatureLabel.text = ""
        
        displayCurrentWeather()
    }

    func displayCurrentWeather() {
        cityLabel.text = city
        countryLabel.text = country
        
        WeatherService.sharedWeatherService().getCurrentWeather(location: city, completion: { (data) -> () in
            OperationQueue.main.addOperation({ () -> Void in
                if let weatherData = data {
                    self.weatherLabel.text = weatherData.weather.capitalized
                    self.temperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
                }
            })
        })
    }

    // MARK: - Action methods
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    }
    
    @IBAction func updateWeatherInfo(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as? LocationTableViewController
        
        if let safeController = sourceViewController {
            city = safeController.selectedCity
            country = safeController.selectedCountry
        }
       
        displayCurrentWeather()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showLocations" {
            let destinationController = segue.destination as? UINavigationController
            
            if let safeDestinationController = destinationController {
                let locationTableViewController = safeDestinationController.viewControllers[0] as? LocationTableViewController
                
                if let safeLocationTableViewController = locationTableViewController {
                    safeLocationTableViewController.selectedLocation = "\(city), \(country)"
                }
            }
        }
    }
}
