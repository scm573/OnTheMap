//
//  AddLocationMapController.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/26.
//

import UIKit
import CoreLocation
import MapKit

class AddLocationMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var coordinate: CLLocationCoordinate2D?
    var link: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let coordinate = coordinate {
            addPinTo(coordinate)
            adjustMapTo(coordinate)
        }
    }
    
    @IBAction func finishAddingLocation(_ sender: Any) {
        
    }
}

extension AddLocationMapViewController {
    func addPinTo(_ coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        lookUpPlacemark(coordinate) { placemark in
            if let placemark = placemark {
                annotation.title = placemark.name
            }
        }
        
        mapView.addAnnotation(annotation)
    }
    
    func adjustMapTo(_ coordinate: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension AddLocationMapViewController {
    func lookUpPlacemark(_ coordinate: CLLocationCoordinate2D, completionHandler: @escaping (CLPlacemark?) -> Void ) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location, completionHandler: {
            (placemarks, error) in
            
            if error == nil {
                let firstLocation = placemarks?[0]
                completionHandler(firstLocation)
            } else {
                completionHandler(nil)
            }
        })
    }
}
