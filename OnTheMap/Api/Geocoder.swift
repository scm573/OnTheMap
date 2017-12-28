//
//  GeoCoder.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/28.
//

import CoreLocation
import SVProgressHUD

internal func getCoordinateOf(addressString : String, completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void) {
    let geocoder = CLGeocoder()
    SVProgressHUD.show()
    
    geocoder.geocodeAddressString(addressString) { (placemarks, error) in
        SVProgressHUD.dismiss()
        
        if error == nil {
            if let placemark = placemarks?[0] {
                let location = placemark.location!
                
                completionHandler(location.coordinate, nil)
                return
            }
        }
        
        completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
    }
}

internal func lookUpPlacemark(_ coordinate: CLLocationCoordinate2D, completionHandler: @escaping (CLPlacemark?) -> Void) {
    let geocoder = CLGeocoder()
    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    SVProgressHUD.show()
    
    geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
        SVProgressHUD.dismiss()
        
        if error == nil {
            let firstLocation = placemarks?[0]
            completionHandler(firstLocation)
        } else {
            completionHandler(nil)
        }
    })
}
