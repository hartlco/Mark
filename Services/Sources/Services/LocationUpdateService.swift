//
//  LocationUpdateService.swift
//  Services
//
//  Created by martin on 12.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import Foundation
import MapKit
import Combine

@available(iOS 13.0, watchOS 6.0, *)
public final class LocationUpdateService: NSObject {
    public static let shared = LocationUpdateService()

    @Published public var location: CLLocation?

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.desiredAccuracy = 50
        locationManager.delegate = self
    }


}

@available(iOS 13.0, watchOS 6.0, *)
extension LocationUpdateService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else {
            manager.startUpdatingLocation()
        }
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        self.location = location
    }


    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

    }
}
