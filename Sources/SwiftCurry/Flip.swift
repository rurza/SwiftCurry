//
//  Flip.swift
//  
//
//  Created by Adam Różyński on 29/03/2021.
//

import Foundation

public func flip<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
    return { b in
        return { a in
            return f(a)(b)
        }
    }
}
