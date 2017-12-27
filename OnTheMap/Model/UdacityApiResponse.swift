//
//  UdacityApiResponse.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2017/12/27.
//

import Foundation

struct UdacityApiResponse: Codable {
    let status: Int?
    let error: String?
    let account: Account?
    
    struct Account: Codable {
        let key: String?
    }
}


