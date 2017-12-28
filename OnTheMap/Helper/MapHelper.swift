//
//  MapHelper.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/27.
//

import MapKit

internal func adjustCameraOf(_ mapView: MKMapView, coordinate: CLLocationCoordinate2D) {
    let regionRadius: CLLocationDistance = 1000
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate,
                                                              regionRadius * 2.0, regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
}

internal func addStudentPinTo(_ mapView: MKMapView, coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate
    annotation.title = title
    annotation.subtitle = subtitle
    mapView.addAnnotation(annotation)
}

internal func addPlacemarkPinTo(_ mapView: MKMapView, coordinate: CLLocationCoordinate2D, completionHandler: @escaping (CLPlacemark?) -> Void) {
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate

    lookUpPlacemark(coordinate) { placemark in
        if let placemark = placemark {
            annotation.title = placemark.name
            mapView.addAnnotation(annotation)
            completionHandler(placemark)
        } else {
            mapView.addAnnotation(annotation)
            completionHandler(nil)
        }
    }
}

internal func removeAllAnnotationsFrom(_ mapView: MKMapView) {
    if mapView.annotations.isEmpty { return }
    for annotation in mapView.annotations {
        mapView.removeAnnotation(annotation)
    }
}
