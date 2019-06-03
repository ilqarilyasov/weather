//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by Ilgar Ilyasov on 6/1/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    var weatherViewModel: WeatherViewModel? {
        didSet { updateViews() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    
    let loader = ImageLoader()
    
    private func updateViews() {
        
        guard isViewLoaded,
            let weatherViewModel = weatherViewModel else { return}
        
        temperatureLabel.text = "\(weatherViewModel.temperature)"
        descriptionLabel.text = weatherViewModel.description
        windLabel.text = "Wind: \(weatherViewModel.windSpeed) mph"
        cloudLabel.text = "Cloudiness: \(weatherViewModel.clouds) %"
        title = weatherViewModel.locationName
        
        loader.loadImage(name: weatherViewModel.icon, completion: { (image, error) in
            if let error = error {
                NSLog("WeatherTableViewController.viewDidLoad error loading image: \(error)")
                // Show alert
            }
            
            if let image = image {
                self.weatherImageView.image = image
            }
        })
    }

}
