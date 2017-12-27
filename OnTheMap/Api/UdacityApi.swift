//
//  UdacityApi.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/27.
//

import Foundation

internal func logInUdacity(_ email: String?, password: String?, completionHandler: @escaping((Data?, URLResponse?, Error?) -> Void)) {
    var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = "{\"udacity\": {\"username\": \"\(email ?? "")\", \"password\": \"\(password ?? "")\"}}".data(using: .utf8)
    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: completionHandler)
    task.resume()
}

internal func logOutUdacity(completionHandler: @escaping((Data?, URLResponse?, Error?) -> Void)) {
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
    let task = session.dataTask(with: request, completionHandler: completionHandler)
    task.resume()
}

internal func requestUserInfo(completionHandler: @escaping((Data?, URLResponse?, Error?) -> Void)) {
    guard let key = AppDelegate.shared.key else { return }
    let request = URLRequest(url: URL(string: "https://www.udacity.com/api/users/\(key)")!)
    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: completionHandler)
    task.resume()
}
