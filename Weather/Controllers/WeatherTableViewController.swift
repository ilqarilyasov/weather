//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Ilgar Ilyasov on 5/31/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let client = NetworkClient()
    let locationManager = CLLocationManager()
    let defaults = UserDefaults.standard
    let center = NotificationCenter.default
    
    var weatherViewModels = [WeatherViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Object lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        center.addObserver(self, selector: #selector(fetchUserLocation),
                           name: .didSaveUserLocation, object: nil)
        
        fetchBothCities()
        fetchUserLocation()
    }
    
    
    // MARK: - Helper
    
    private func fetchBothCities() {
        client.fetchWeatherByCity(name: StringValue.london.rawValue) { (weather, error) in
            if let error = error {
                switch error {
                case .networkError:
                    let alert = UIAlertController.createSimpleDismissibleAlert(with: "Network Error", message: "There was an error. We couldn't get weather for London.")
                    self.present(alert, animated: true, completion: nil)
                case .dataError:
                    let alert = UIAlertController.createSimpleDismissibleAlert(with: "Data Error", message: "There was an error. We couldn't get weather for London.")
                    self.present(alert, animated: true, completion: nil)
                case .decodingError:
                    let alert = UIAlertController.createSimpleDismissibleAlert(with: "Decoding Error", message: "There was an error. We couldn't get weather for London.")
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            if let weather = weather {
                let weatherViewModel = WeatherViewModel(weather: weather)
                self.weatherViewModels.append(weatherViewModel)
            }
        }
        
        client.fetchWeatherByCity(name: StringValue.tokyo.rawValue) { (weather, error) in
            if let error = error {
                switch error {
                case .networkError:
                    let alert = UIAlertController.createSimpleDismissibleAlert(with: "Network Error", message: "There was an error. We couldn't get weather for Tokyo.")
                    self.present(alert, animated: true, completion: nil)
                case .dataError:
                    let alert = UIAlertController.createSimpleDismissibleAlert(with: "Data Error", message: "There was an error. We couldn't get weather for Tokyo.")
                    self.present(alert, animated: true, completion: nil)
                case .decodingError:
                    let alert = UIAlertController.createSimpleDismissibleAlert(with: "Decoding Error", message: "There was an error. We couldn't get weather for Tokyo.")
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            if let weather = weather {
                let weatherViewModel = WeatherViewModel(weather: weather)
                self.weatherViewModels.append(weatherViewModel)
            }
        }
    }
    
    @objc
    private func fetchUserLocation() {
        guard let userLocation = defaults.object(forKey: StringValue.userLocation.rawValue) as? [Double] else { return }
        let location = Coordinate(lat: userLocation[0], lon: userLocation[1])
        
        client.fetchWeatherBy(location: location) { (weather, error) in
            if let error = error {
                switch error {
                case .networkError:
                    let alert = UIAlertController.createSimpleDismissibleAlert(with: "Network Error", message: "There was an error. We couldn't get weather for your location.")
                    self.present(alert, animated: true, completion: nil)
                case .dataError:
                    let alert = UIAlertController.createSimpleDismissibleAlert(with: "Data Error", message: "There was an error. We couldn't get weather for your location.")
                    self.present(alert, animated: true, completion: nil)
                case .decodingError:
                    let alert = UIAlertController.createSimpleDismissibleAlert(with: "Decoding Error", message: "There was an error. We couldn't get weather for your location.")
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            if let weather = weather, self.weatherViewModels.count < 3 {
                let weatherViewModel = WeatherViewModel(weather: weather)
                self.weatherViewModels.insert(weatherViewModel, at: 0)
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StringValue.reuseidentifier.rawValue, for: indexPath)

        guard let weatherCell = cell as? WeatherTableViewCell else { return cell }
        
        let weatherViewModel = weatherViewModels[indexPath.row]
        weatherCell.weatherViewModel = weatherViewModel

        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StringValue.segueIdentifier.rawValue {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? WeatherDetailViewController else { return }
            
            let weatherViewModel = weatherViewModels[indexPath.row]
            destinationVC.weatherViewModel = weatherViewModel
        }
    }
}

extension WeatherTableViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .denied:
            let alert = UIAlertController.createSimpleDismissibleAlert(with: "Denied", message: "Location services are currently disabled in Settings.")
            present(alert, animated: true, completion: nil)
        case .restricted:
            let alert = UIAlertController.createSimpleDismissibleAlert(with: "Restricted", message: "We cann't access your location.\nPossibly due to active restrictions such as parental controls being in place.")
            present(alert, animated: true, completion: nil)
        default:
            break
        }
    }
}
