//
//  Dictionary+Ext.swift
//  shopVS
//
//  Created by Home on 10.04.2022.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    
    mutating func append(anotherDict: [String : Any]) -> [String : Any] {
        var newDict = self
        for (key, value) in anotherDict {
            newDict.updateValue(value, forKey: key)
        }
        return newDict
    }
}
