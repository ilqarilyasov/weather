//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Ilgar Ilyasov on 5/31/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    // MARk: - Instance Properties
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    let loader = ImageLoader()

    var weatherViewModel: WeatherViewModel? {
        didSet { updateViews() }
    }
    
    
    private func updateViews() {
        guard let weatherViewModel = weatherViewModel else { return }
        
        locationNameLabel.text = weatherViewModel.locationName
        temperatureLabel.text = "\(weatherViewModel.temperature)"
        descriptionLabel.text = weatherViewModel.description
        
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        locationNameLabel.text = nil
        temperatureLabel.text = nil
        descriptionLabel.text = nil
        weatherImageView.image = nil
    }
}
