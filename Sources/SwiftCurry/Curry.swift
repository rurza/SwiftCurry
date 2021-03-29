//
//  Curry.swift
//  
//
//  Created by Adam Różyński on 29/03/2021.
//

import Foundation

public func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in
        return { b in
            return f(a, b)
        }
    }
}

public func uncurry<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (A, B) -> C {
    return { a, b in
        return f(a)(b)
    }
}

public func zurry<A>(_ f: () -> A) -> A {
    return f()
}
