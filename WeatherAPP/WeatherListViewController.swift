//
//  MasterViewController.swift
//  WeatherAPP
//
//  Created by ruixue on 7/10/17.
//  Copyright © 2017 rui. All rights reserved.
//

import UIKit

class WeatherListViewController: UITableViewController {
    
    private let viewModel = WeatherListViewModel()

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let city = viewModel.city(at: indexPath.row),
                    let weatherDetails = viewModel.weatherDetails(forCity: city.1) else { return }
                let controller = segue.destination as! DetailViewController
                controller.weatherDetails = weatherDetails
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCities
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell

        if let city = viewModel.city(at: indexPath.row) {
            cell.cityLabel.text = city.0
            
            cell.loadingIndicator.isHidden = false
            cell.loadingIndicator.startAnimating()
            viewModel.fetchWeather(for: city.1) { [weak self] error in
                DispatchQueue.main.sync {
                    guard let sself = self else { return }
                    cell.loadingIndicator.stopAnimating()
                    cell.loadingIndicator.isHidden = true
                    if error == nil, let temperature = sself.viewModel.temperature(forCity: city.1) {
                        cell.temperatureLabel.text = "\(temperature)"
                    } else {
                        cell.temperatureLabel.text = "Loading error!"
                    }
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
}
