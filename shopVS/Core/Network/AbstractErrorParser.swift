//
//  AbstractErrorParser.swift
//  shopVS
//
//  Created by Home on 15.02.2022.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
