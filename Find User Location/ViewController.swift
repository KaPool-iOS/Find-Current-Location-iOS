//
//  ViewController.swift
//  Find User Location
//
//  Created by Jake Vo on 1/1/17.
//  Copyright © 2017 Jake Vo. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var longtitude: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //let coordinate = locations [0].coordinate
        let userLocation = locations [0]
        self.altitude.text =  String (userLocation.altitude)
        self.latitude.text = String (userLocation.coordinate.latitude)
        self.longtitude.text = String (userLocation.coordinate.longitude)
        self.speed.text = String (userLocation.speed)
        self.course.text = String (userLocation.course)
        
        let latitudeMap: CLLocationDegrees = userLocation.coordinate.latitude
        
        let longtitudeMap: CLLocationDegrees = userLocation.coordinate.longitude
        
        let latDelta: CLLocationDegrees =  0.05
        let lonDelta: CLLocationDegrees = 0.05
        
        //zoom level of the map
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitudeMap, longitude: longtitudeMap)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        map.setRegion(region, animated: true)
        
       
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if error != nil {
                
                print(error!)
                
            } else {
                
                if let placemark = placemarks?[0] {
                    
                    var address = ""
                    
                    if placemark.subThoroughfare != nil {
                        
                        address += placemark.subThoroughfare! + " "
                        
                    }
                    
                    if placemark.thoroughfare != nil {
                        
                        address += placemark.thoroughfare! + " "
                        
                    }
                    
                    if placemark.subLocality != nil {
                        
                        address += placemark.subLocality! + ", "
                        
                    }
                    
                    if placemark.subAdministrativeArea != nil {
                        
                        address += placemark.subAdministrativeArea! + ", "
                        
                    }
                    
                    if placemark.postalCode != nil {
                        
                        address += placemark.postalCode! + "\n"
                        
                    }
                    
                    if placemark.country != nil {
                        
                        address += placemark.country!
                        
                    }

                    self.address.text = address
                    
                }
            }
        }
    }
}

