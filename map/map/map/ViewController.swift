//
//  ViewController.swift
//  map
//
//  Created by Роман Зобнин on 22.02.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMapView()
        let firstCoordinate = CLLocationCoordinate2D(latitude: 59.925737, longitude: 30.297420)
        let secondCoordinate = CLLocationCoordinate2D(latitude: 59.921771, longitude: 30.335083)
        route(firstCoordinate: firstCoordinate, secondCoordinate: secondCoordinate)
        
    }
    
    func initMapView() {
        mapView = MKMapView(frame: view.bounds)
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    func route (firstCoordinate: CLLocationCoordinate2D, secondCoordinate: CLLocationCoordinate2D) {
        
        let firstAnnotation = MKPointAnnotation()
        firstAnnotation.title = "1"
        firstAnnotation.coordinate = firstCoordinate
        
        let secondAnnotation = MKPointAnnotation()
        secondAnnotation.title = "2"
        secondAnnotation.coordinate = secondCoordinate
        
        mapView.showAnnotations([firstAnnotation,secondAnnotation], animated: true)
        
        let firstItem = MKMapItem(placemark: MKPlacemark(coordinate: firstCoordinate))
        let secondItem = MKMapItem(placemark: MKPlacemark(coordinate: secondCoordinate))
        
        let request = MKDirections.Request()
        request.source = firstItem
        request.destination = secondItem
        
        request.transportType = .walking 
        
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard let response = response else {return}
            
            if response.routes.count > 0 {
                let route = response.routes.first!
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 3
        renderer.strokeColor = .red
        return renderer
    }
}

