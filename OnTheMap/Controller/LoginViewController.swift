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
            let decoder: JSONDecoder = JSONDecoder()
            do {
                let udacityAuthApiResponse: UdacityAuthApiResponse = try decoder.decode(UdacityAuthApiResponse.self, from: data!)
                
                if udacityAuthApiResponse.error == nil {
                    performUIUpdatesOnMain {
                        self.performSegue(withIdentifier: "loggedIn", sender: nil)
                        self.passwordTextField.text = ""
                        AppDelegate.shared.key = udacityAuthApiResponse.account?.key
                        
                        requestUserInfo { data, response, error in
                            let decoder: JSONDecoder = JSONDecoder()
                            do {
                                let udacityPublicApiResponse: UdacityPublicApiResponse = try decoder.decode(UdacityPublicApiResponse.self, from: data!)
                                
                                performUIUpdatesOnMain {
                                    AppDelegate.shared.user = udacityPublicApiResponse.user
                                }
                            } catch {
                                print("json convert failed in JSONDecoder", error.localizedDescription)
                            }
                        }
                    }
                } else {
                    presentAlert(title: "Authentication failed", message: udacityAuthApiResponse.error?.description ?? "", preferredStyle: .alert, actionTitle: "Try again")
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

