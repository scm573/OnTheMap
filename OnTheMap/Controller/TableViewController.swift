//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/26.
//

import UIKit

class TableViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logOut(_ sender: Any) {
        logOutUdacity { data, response, error in
            if error != nil {
                performUIUpdatesOnMain {
                    let alert = UIAlertController(title: "Network error", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            performUIUpdatesOnMain {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
