//
//  UdacityApi.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/27.
//

import Foundation
import SVProgressHUD

internal func logInUdacity(_ email: String?, password: String?, completionHandler: @escaping((Data?, URLResponse?, Error?) -> Void)) {
    if !ReachabilityHelper.isNetworkConnected() {
        presentAlert(title: "Network error", message: "No network connection.", preferredStyle: .alert, actionTitle: "Try again")
        return
    }
    
    var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = "{\"udacity\": {\"username\": \"\(email ?? "")\", \"password\": \"\(password ?? "")\"}}".data(using: .utf8)
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
        SVProgressHUD.dismiss()
        if let httpResponse = response as? HTTPURLResponse {
            if 400...599 ~= httpResponse.statusCode {
                presentAlert(title: "Server error", message: "Something exploded.", preferredStyle: .alert, actionTitle: "Try again")
                return
            }
        }
        if error != nil {
            presentAlert(title: "Network error", message: error?.localizedDescription ?? "", preferredStyle: .alert, actionTitle: "Try again")
            return
        }
        
        let range = Range(5..<data!.count)
        let newData = data?.subdata(in: range)
        completionHandler(newData, response, error)
    }
    SVProgressHUD.show()
    task.resume()
}

internal func logOutUdacity(completionHandler: @escaping((Data?, URLResponse?, Error?) -> Void)) {
    if !ReachabilityHelper.isNetworkConnected() {
        presentAlert(title: "Network error", message: "No network connection.", preferredStyle: .alert, actionTitle: "Try again")
        return
    }
    
    var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
    request.httpMethod = "DELETE"
    var xsrfCookie: HTTPCookie? = nil
    let sharedCookieStorage = HTTPCookieStorage.shared
    for cookie in sharedCookieStorage.cookies! {
        if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
    }
    if let xsrfCookie = xsrfCookie {
        request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
    }
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
        SVProgressHUD.dismiss()
        if let httpResponse = response as? HTTPURLResponse {
            if 400...599 ~= httpResponse.statusCode {
                presentAlert(title: "Server error", message: "Something exploded.", preferredStyle: .alert, actionTitle: "Try again")
                return
            }
        }
        if error != nil {
            presentAlert(title: "Network error", message: error?.localizedDescription ?? "", preferredStyle: .alert, actionTitle: "Try again")
            return
        }
        completionHandler(data, response, error)
    }
    SVProgressHUD.show()
    task.resume()
}

internal func requestUserInfo(completionHandler: @escaping((Data?, URLResponse?, Error?) -> Void)) {
    if !ReachabilityHelper.isNetworkConnected() { return }
    
    guard let key = AppDelegate.shared.key else { return }
    let request = URLRequest(url: URL(string: "https://www.udacity.com/api/users/\(key)")!)
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
        if let httpResponse = response as? HTTPURLResponse {
            if 400...599 ~= httpResponse.statusCode { return }
        }
        if error != nil { return }
        let range = Range(5..<data!.count)
        let newData = data?.subdata(in: range)
        completionHandler(newData, response, error)
    }
    task.resume()
}
