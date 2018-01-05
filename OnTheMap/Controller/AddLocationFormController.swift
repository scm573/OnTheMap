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
        locationTextField.delegate = self
        linkTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
        super.viewWillDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addLocation" {
            let mapVC = segue.destination as! AddLocationMapViewController
            mapVC.coordinate = coordinate
            mapVC.link = linkTextField.text
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

extension AddLocationFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddLocationFormViewController {
    @objc func keyboardWillShow(_ notification:Notification) {
        if linkTextField.isFirstResponder {
            view.frame.origin.y = -(getKeyboardHeight(notification) / 2)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
}
