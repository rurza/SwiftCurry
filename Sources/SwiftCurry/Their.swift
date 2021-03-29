//
//  Their.swift
//  
//
//  Created by Adam Różyński on 29/03/2021.
//

import Foundation

public func their<Root, Value>(_ f: @escaping (Root) -> Value, g: @escaping (Value, Value) -> Bool) -> (Root, Root) -> Bool {
    return { r1, r2 in
        return g(f(r1), f(r2))
    }
}
