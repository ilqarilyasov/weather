//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by Ilgar Ilyasov on 6/1/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    // MARK: - Properties
    
    let loader = ImageLoader()
    var weatherViewModel: WeatherViewModel? {
        didSet { updateViews() }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    
    
    // MARK: - Object lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    
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
