//
//  AddLocationFormController.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/26.
//

import UIKit
import CoreLocation

class AddLocationFormViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    
    var coordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addLocation" {
            let mapVC = segue.destination as! AddLocationMapViewController
            mapVC.coordinate = coordinate
            mapVC.link = linkTextField.text
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocation(_ sender: Any) {
        getCoordinateOf(addressString: locationTextField.text ?? "") { coordinate , error in
            
            if let error = error {
                presentAlert(title: "Location not found", message: error.description, preferredStyle: .alert, actionTitle: "OK")
                return
            }
            
            self.coordinate = coordinate
            self.performSegue(withIdentifier: "addLocation", sender: self)
        }
    }
    
}
