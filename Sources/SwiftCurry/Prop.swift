//
//  Prop.swift
//  
//
//  Created by Adam Różyński on 27/03/2021.
//

import Foundation

public func prop<Root, Value>(_ kp: WritableKeyPath<Root, Value>) -> (@escaping (Value) -> Value) -> (Root) -> Root {
    return { update in
        return { root in
            var copy = root
            copy[keyPath: kp] = update(copy[keyPath: kp])
            return copy
        }
    }
}


