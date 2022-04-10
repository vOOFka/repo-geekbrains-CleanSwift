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
    var defaultParameters: [String : Any] = [
        "file" : #file,
        "func" : #function,
        "line" : #line
    ]
    
    private init() { }
    
    func logError(_ name: String? = nil, error: Error? = nil, param: [String: Any]? = nil) {
        let allParameters = defaultParameters.append(anotherDict: param ?? [:])
        let customError = error ?? NSError(domain: name ?? "", code: -123, userInfo: allParameters)
        
        Crashlytics.crashlytics().record(error: customError)
    }
    
    func logEvent(_ event: String, param: [String: Any]? = nil) {
        let allParameters = defaultParameters.append(anotherDict: param ?? [:])
        
        Analytics.logEvent(event, parameters: allParameters)
    }
}
