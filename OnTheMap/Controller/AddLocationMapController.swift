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
    var placemark: CLPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let coordinate = coordinate {
            addPlacemarkPinTo(mapView, coordinate: coordinate) { placemark in
                self.placemark = placemark
            }
            adjustCameraOf(mapView, coordinate: coordinate)
        }
    }
    
    @IBAction func finishAddingLocation(_ sender: Any) {
        guard let coordinate = coordinate else { return }
        postStudentData(mapString: placemark?.name ?? "", mediaURL: link ?? "", latitude: coordinate.latitude, longitude: coordinate.longitude) { data, response, error in
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
