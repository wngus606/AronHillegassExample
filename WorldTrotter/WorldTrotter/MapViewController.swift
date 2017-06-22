//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by seo on 2017. 6. 20..
//  Copyright © 2017년 seoju. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    override func loadView() {
        // 지도 뷰 생성
        self.mapView = MKMapView()
        self.mapView.delegate = self
//        self.mapView.showsUserLocation = true
        
        // 지도 뷰를 뷰 컨트롤러의 view로 설정
        self.view = self.mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(segControl:)), for: .valueChanged)
        self.view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingContraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingContraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingContraint.isActive = true
        trailingContraint.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsLocationManager()
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    // MARK: - CLLocation Manger
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.mapView.showsUserLocation = true
    }
    
    func settingsLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension MapViewController: MKMapViewDelegate {
    
    // MARK: - MapView
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.setCenter(userLocation.coordinate, animated: true)
    }
}
