//
//  Get.swift
//  
//
//  Created by Adam Różyński on 29/03/2021.
//

import Foundation

public func get<Root, Value>(_ kp: KeyPath<Root, Value>) -> (Root) -> Value {
    return { root in
        return root[keyPath: kp]
    }
}
