//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/26.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AppDelegate.shared.studentData == nil {
            requestData()
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        requestData()
    }
    
    @IBAction func logOut(_ sender: Any) {
        logOutUdacity { data, response, error in
            performUIUpdatesOnMain {
                self.dismiss(animated: true, completion: nil)
                AppDelegate.shared.key = nil
                AppDelegate.shared.studentData = nil
            }
        }
    }
}

extension MapViewController {
    func requestData() {
        requestStudentData { data, response, error in
            let decoder: JSONDecoder = JSONDecoder()
            do {
                let parseApiResponse: ParseApiResponse = try decoder.decode(ParseApiResponse.self, from: data!)
                performUIUpdatesOnMain {
                    AppDelegate.shared.studentData = parseApiResponse
                    self.setMapPins()
                }
            } catch {
                print("json convert failed in JSONDecoder", error.localizedDescription)
            }
        }
    }
    
    func setMapPins() {
        removeAllAnnotationsFrom(mapView)
        
        guard let studentLocations = AppDelegate.shared.studentData?.results else { return }
        if studentLocations.isEmpty { return }
        
        if let lat = studentLocations[0].latitude, let lng = studentLocations[0].longitude {
            adjustCameraOf(mapView, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng))
        }
        
        for studentLocation in studentLocations {
            if let lat = studentLocation.latitude, let lng = studentLocation.longitude, let firstName = studentLocation.firstName, let lastName = studentLocation.lastName, let link = studentLocation.mediaURL {
                addStudentPinTo(mapView, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng),
                                title: "\(firstName) \(lastName)", subtitle: link)
            }
        }
    }
}
