//
//  ViewController.swift
//  RouteMap
//
//  Created by Dante Solorio on 3/30/16.
//  Copyright © 2016 Dante Solorio. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var map: MKMapView!
    @IBOutlet var segmentContoller: UISegmentedControl!
    
    let locationManager = CLLocationManager()
    var distance = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        /*
        var annotation = CLLocationCoordinate2D()
        annotation.latitude = 19.52748
        annotation.longitude = -96.92315
        
        let pin = MKPointAnnotation()
        pin.title = "Title pin"
        pin.subtitle = "Subtitle pin"
        pin.coordinate = annotation
        
        map.addAnnotation(pin)
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse{
            locationManager.startUpdatingLocation()
            locationManager.distanceFilter = 50.0
            map.showsUserLocation = true
        }else{
            locationManager.stopUpdatingLocation()
            map.showsUserLocation = false
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)

        
        var annotation = CLLocationCoordinate2D()
        annotation.latitude = (locationManager.location?.coordinate.latitude)!
        annotation.longitude = (locationManager.location?.coordinate.longitude)!

        let pin = MKPointAnnotation()
        pin.title = "Latitude: "+String((locationManager.location?.coordinate.latitude)!)+", Longitude:"+String((locationManager.location?.coordinate.longitude)!)
        pin.subtitle = "Current distance: "+String(distance)+" km."
        pin.coordinate = annotation
        map.addAnnotation(pin)
        distance = distance + 50
    }
    
    @IBAction func changeMapType(sender:UISegmentedControl){        
        switch sender.selectedSegmentIndex {
        case 0:
            map.mapType = MKMapType.Standard
        case 1:
            map.mapType = MKMapType.Satellite
        case 2:
            map.mapType = MKMapType.Hybrid
        default:
            break
        }
    }


}

