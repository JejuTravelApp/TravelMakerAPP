//
//  UserLocationManager.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/27/24.
//  Description: 위치권한 동의를 묻고, 유저의 위치를 가져오는 뷰모델

import Foundation
import CoreLocation

class UserLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation = CLLocationCoordinate2D()
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.userLocation = location.coordinate
        }
    }
}

