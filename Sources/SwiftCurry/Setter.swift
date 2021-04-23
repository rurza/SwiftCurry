//
//  Setter.swift
//  
//
//  Created by Adam Różyński on 22/04/2021.
//


public typealias Setter<S, T, A, B> = (@escaping (A) -> B) -> (S) -> T

/// this allows us to use `prop` with their overloads
/// - Parameters:
///   - setter: any "setter" function, like prop or map
///   - f: a function that will return the new value
/// - Returns: function that will allow us to change a bigger structure
public func over<S, T, A, B>(
    _ setter: Setter<S, T, A, B>,
    _ f: @escaping (A) -> B
)
-> (S)
-> T {
    setter(f)
}

/// this allows us to use `prop` with their overloads
/// - Parameters:
///   - setter: any "setter" function, like prop or map
///   - value: we want to set
/// - Returns: function that will allow us to change a bigger structure
public func set<S, T, A, B>(
    _ setter: Setter<S, T, A, B>,
    _ value: B)
-> (S)
-> T {
    setter { _ in value}
}

public typealias MutableSetter<S, A> = (@escaping (inout A) -> Void) -> (inout S) -> Void

public func mver<S, A>(
    _ setter: MutableSetter<S, A>,
    _ set: @escaping (inout A) -> Void
)
-> (inout S)
-> Void {
    setter(set)
}

public func mut<S, A>(
    _ setter: MutableSetter<S, A>,
    _ set: A
)
-> (inout S)
-> Void {
    setter { $0 = set }
}
