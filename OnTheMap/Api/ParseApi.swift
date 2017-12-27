//
//  ParseApi.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/27.
//

import Foundation

internal func requestStudentData(completionHandler: @escaping((Data?, URLResponse?, Error?) -> Void)) {
    var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: completionHandler)
    task.resume()
}

internal func postStudentData(mapString: String, mediaURL: String, latitude: Double, longitude: Double, completionHandler: @escaping((Data?, URLResponse?, Error?) -> Void)) {
    guard let key = AppDelegate.shared.key else { return }
    let firstName = AppDelegate.shared.user?.first_name ?? ""
    let lastName = AppDelegate.shared.user?.last_name ?? ""
    
    var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
    request.httpMethod = "POST"
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = "{\"uniqueKey\": \"\(key)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}".data(using: .utf8)
    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: completionHandler)
    task.resume()
}
