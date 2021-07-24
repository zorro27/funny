//
//  ViewController.swift
//  map-test
//
//  Created by Роман Зобнин on 23.02.2021.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var CheckPoint1Button: UIButton!
    @IBOutlet weak var CheckPoint2Button: UIButton!
    @IBOutlet weak var CheckPoint3Button: UIButton!
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkLocationServices () {
        setupLocationManager()
    }
    
    func checkLocationAuthorization(){
        let manager = CLLocationManager()
        switch CLLocationManager.authorizationStatus (){
        case :
            <#code#>
        default:
            <#code#>
        }
    }
    
}

