//
//  ReachabilityHelper.swift
//  OnTheMap
//
//  Created by Wu, Qifan | Keihan | ECID on 2018/01/05.
//

import Reachability

class ReachabilityHelper {
    static func isNetworkConnected() -> Bool {
        let conn = Reachability()?.connection
        switch conn {
        case .none:
            return false
        default:
            return true
        }
    }
}
