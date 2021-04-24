//
//  Prop.swift
//  
//
//  Created by Adam Różyński on 27/03/2021.
//

import Foundation

public func prop<Root, Value>(_ kp: WritableKeyPath<Root, Value>)
-> (@escaping (Value) -> Value)
-> (Root) -> Root {
    return { update in
        return { root in
            var copy = root
            copy[keyPath: kp] = update(copy[keyPath: kp])
            return copy
        }
    }
}

/// override for setting the value, uncurried prop
public func prop<Root, Value>(
    _ kp: WritableKeyPath<Root, Value>,
    _ value: Value
) -> (Root) -> Root {
    prop(kp) { _ in value }
}

/// override for mapping over
public func prop<Root, Value>(
    _ kp: WritableKeyPath<Root, Value>,
    _ f: @escaping (Value) -> Value
) -> (Root) -> Root {
    prop(kp)(f)
}

public func prop<Root: AnyObject, Value>(_ kp: WritableKeyPath<Root, Value>)
-> (@escaping (inout Value) -> Void)
-> (Root) -> Void {
    return { update in
        { root in
            var root = root
            update(&root[keyPath: kp])
        }
    }
}
