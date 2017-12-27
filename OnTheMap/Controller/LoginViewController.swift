//
//  ViewController.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/26.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signupTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setSignupText()
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

