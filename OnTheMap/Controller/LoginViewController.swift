//
//  ViewController.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/26.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signupTextView: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setSignupText()
    }

    @IBAction func logIn(_ sender: Any) {
        logInUdacity(emailTextField.text, password: passwordTextField.text) { data, response, error in
            if error != nil {
                performUIUpdatesOnMain {
                    let alert = UIAlertController(title: "Network error", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range)
            
            let decoder: JSONDecoder = JSONDecoder()
            do {
                let udacityApiResponse: UdacityApiResponse = try decoder.decode(UdacityApiResponse.self, from: newData!)
                
                if udacityApiResponse.error == nil {
                    performUIUpdatesOnMain {
                        AppDelegate.shared.udacityKey = udacityApiResponse.account?.key
                        self.performSegue(withIdentifier: "loggedIn", sender: nil)
                        self.passwordTextField.text = ""
                    }
                } else {
                    performUIUpdatesOnMain {
                        let alert = UIAlertController(title: "Authentication failed", message: udacityApiResponse.error?.description, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            } catch {
                print("json convert failed in JSONDecoder", error.localizedDescription)
            }
        }
    }
}

extension LoginViewController {
    fileprivate func setSignupText() {
        let mutableString = NSMutableAttributedString(string: "Don't have an account? Sign Up")
        let range = mutableString.mutableString.range(of: "Sign Up")
        let link = URL(string: "https://www.udacity.com/account/auth#!/signup")!
        mutableString.addAttribute(NSAttributedStringKey.link, value: link, range: range)
        signupTextView.isEditable = false
        signupTextView.dataDetectorTypes = .link
        signupTextView.attributedText = mutableString
        signupTextView.textAlignment = .center
    }
}

