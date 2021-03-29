//
//  Map.swift
//  
//
//  Created by Adam Różyński on 28/03/2021.
//

import Foundation

/// Transform arrays of As into array of Bs by passing function that can transform A into B
/// - Returns: array of Bs
public func map<A, B>(_ f: @escaping (A) -> B) -> ([A]) -> [B] {
    return {
        return $0.map(f)
    }
}

/// Unwraps Optional, change its value and return a new optional with the new value
public func map<A, B>(_ f: @escaping (A) -> B) -> (A?) -> B? {
    return {
        return $0.map(f)
    }
}
