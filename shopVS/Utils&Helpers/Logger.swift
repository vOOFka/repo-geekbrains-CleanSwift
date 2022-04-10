//
//  Logger.swift
//  shopVS
//
//  Created by Home on 10.04.2022.
//

import Foundation
import Firebase

class Logger {
    static let shared = Logger()
    
    private init() { }
    
    func logError(_ name: String? = nil, error: Error? = nil, param: [String: Any]? = nil) {
        let customError = error ?? NSError(domain: name ?? "", code: -123, userInfo: param)        
        Crashlytics.crashlytics().record(error: customError)
    }
    
    func logEvent(_ event: String, param: [String: Any]? = nil) {
        Analytics.logEvent(event, parameters: param)
    }
}
