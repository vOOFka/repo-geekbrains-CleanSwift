//
//  Array+Ext.swift
//  shopVS
//
//  Created by Home on 08.03.2022.
//

import Foundation

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
