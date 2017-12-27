//
//  UdacityApiResponse.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/27.
//

import Foundation

struct UdacityAuthApiResponse: Codable {
    let status: Int?
    let error: String?
    let account: Account?
    
    struct Account: Codable {
        let key: String?
    }
}

struct UdacityPublicApiResponse: Codable {
    let user: User?
    
    struct User: Codable {
        let first_name: String?
        let last_name: String?
    }
}
