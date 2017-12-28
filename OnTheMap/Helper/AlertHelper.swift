//
//  AlertHelper.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/28.
//

import UIKit

internal func presentAlert(title: String, message: String, preferredStyle: UIAlertControllerStyle, actionTitle: String) {
    performUIUpdatesOnMain {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        rootViewController?.present(alert, animated: true, completion: nil)
    }
}
