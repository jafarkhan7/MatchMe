//
//  LocationManager.swift
//  MatchMe
//
//  Created by Abdus Mac on 8/9/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    
    private override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    var location: CLLocation? {
        return locationManager.location
    }
    
    
    
}
