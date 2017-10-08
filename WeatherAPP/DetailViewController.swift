//
//  DetailViewController.swift
//  WeatherAPP
//
//  Created by ruixue on 7/10/17.
//  Copyright © 2017 rui. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet fileprivate weak var summaryLabel: UILabel!
    @IBOutlet fileprivate weak var pressureLabel: UILabel!
    @IBOutlet fileprivate weak var humidityLabel: UILabel!
    @IBOutlet fileprivate weak var maxTemperatureLabel: UILabel!
    @IBOutlet fileprivate weak var minTemperatureLabel: UILabel!
    
    var weatherDetails: WeatherDetails? {
        didSet {
            configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = weatherDetails?.city
        configureView()
        animate()
    }
}

private extension DetailViewController {
    func configureView() {
        // Update the user interface for the detail item.
        guard let details = weatherDetails else { return }
        summaryLabel?.text = details.weather.summary
        pressureLabel?.text = "\(details.main.pressure)"
        humidityLabel?.text = "\(details.main.humidity)"
        maxTemperatureLabel?.text = "\(details.main.temperatureMax)"
        minTemperatureLabel?.text = "\(details.main.temperatureMin)"
    }
    
    func animate() {
        UIView.animate(withDuration: 2) {
            self.summaryLabel.alpha = 1
        }
    }
}

