//
//  ParseApiResponse.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/27.
//

import Foundation

struct ParseApiResponse: Codable {
    let results: [StudentLocation]?
    
    struct StudentLocation: Codable {
        let objectId: String?
        let uniqueKey: String?
        let firstName: String?
        let lastName: String?
        let mapString: String?
        let mediaURL: String?
        let latitude: Double?
        let longitude: Double?
        let createdAt: String?
        let updatedAt: String?
    }
}
