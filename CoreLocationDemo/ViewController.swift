//
//  ViewController.swift
//  CoreLocationDemo
//
//  Created by Brendan Miller on 2022-12-04.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager = CLLocationManager()
    var currentLocation = CLLocation()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        manager.delegate = self
        
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude), latitudinalMeters: 1, longitudinalMeters: 1)
    }
    
    @IBOutlet weak var longLabel: UILabel!
    
    @IBOutlet weak var latLabel: UILabel!

    @IBOutlet weak var mapView: MKMapView!
    
    //happens as soon delegate is set, iOS checks if authorization has been given
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        switch manager.authorizationStatus{
        case .authorizedAlways:
            enableLocationFeatures()
        case .restricted, .denied:
            disableLocationFeatures()
        case .notDetermined:
            manager.requestAlwaysAuthorization()
        default:
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else{
            print("cant find location")
            return
        }
        currentLocation = location
        
        let lng: Double = currentLocation.coordinate.longitude
        let lat: Double = currentLocation.coordinate.latitude
        
        longLabel.text = String(format: "%f", lng)
        latLabel.text = String(format: "%f", lat)
        
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lng), latitudinalMeters: 1, longitudinalMeters: 1)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         
    }
   
    
    func enableLocationFeatures(){
        
        //set these properties to conserve battery on device
        manager.activityType = .fitness
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        //starts location service
        manager.startUpdatingLocation()
        
        //requests current location
        manager.requestLocation()
    }
    
    func disableLocationFeatures(){
        
    }

}

