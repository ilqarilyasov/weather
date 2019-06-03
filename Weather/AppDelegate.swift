//
//  AppDelegate.swift
//  Weather
//
//  Created by Ilgar Ilyasov on 5/31/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let defaults = UserDefaults.standard
    let locationManager = CLLocationManager()
    let center = NotificationCenter.default

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        return true
    }
}

extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude

        if defaults.object(forKey: StringValue.userLocation.rawValue) == nil {
            defaults.set([latitude, longitude], forKey: StringValue.userLocation.rawValue)
            center.post(name: .didSaveUserLocation, object: nil)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("Failed to find user's location: \(error.localizedDescription)")
    }
}

