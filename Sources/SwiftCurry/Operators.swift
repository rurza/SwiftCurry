//
//  Operators.swift
//
//  Created by Adam Różyński on 31/01/2021.
//

// MARK: |>
precedencegroup ForwardApplication {
    associativity: left
}
infix operator |>: ForwardApplication

public func |> <A, B>(x: A, f: (A) -> B) -> B {
    return f(x)
}

public func |> <A>(_ a: A, _ f: (inout A) -> Void) -> A {
    var a = a
    f(&a)
    return a
}

// MARK: >>>
precedencegroup ForwardComposition {
    associativity: left
    higherThan: SingleTypeComposition, EffectfulComposition
}
infix operator >>>: ForwardComposition

public func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}


// MARK: <<<
precedencegroup BackwardComposition {
    associativity: left
    higherThan: SingleTypeComposition, EffectfulComposition
}
infix operator <<<: BackwardComposition

public func <<< <A, B, C>(f: @escaping (B) -> C, g: @escaping (A) -> B) -> (A) -> C {
    return { f(g($0)) }
}


// MARK: >=>
precedencegroup EffectfulComposition {
    associativity: left
    higherThan: ForwardApplication
}
infix operator >=>: EffectfulComposition

public func >=> <A, B, C>(f: @escaping (A) -> B?, g: @escaping (B) -> C?) -> (A) -> C? {
    return { a in
        guard let b = f(a) else { return nil }
        return g(b)
    }
}

public func >=> <A, B, C>(f: @escaping (A) -> [B], g: @escaping (B) -> [C]) -> (A) -> [C] {
    return { a in
        let bs = f(a)
        return bs.flatMap { b in g(b) }
    }
}


// MARK: <>
precedencegroup SingleTypeComposition {
    associativity: right
    higherThan: ForwardApplication
}
infix operator <>: SingleTypeComposition
public func <> <A>(f: @escaping (A) -> A, g: @escaping (A) -> A) -> (A) -> A {
    return f >>> g
}

public func <> <A>(f: @escaping (inout A) -> Void, g: @escaping (inout A) -> Void) -> (inout A) -> Void {
    return { a in
        f(&a)
        g(&a)
    }
}

public func <> <A: AnyObject>(f: @escaping (A) -> Void, g: @escaping (A) -> Void) -> (A) -> Void {
    return { a in
        f(a)
        g(a)
    }
}

// MARK: ^
prefix operator ^
/// getter operator
/// - Parameter kp: the keypath you want to get
/// - Returns: a function that'll return a value from specified target
public prefix func ^ <Root, Value>(kp: KeyPath<Root, Value>) -> (Root) -> Value {
    return get(kp)
}

/// setter operator
/// - Parameter kp: they keypath of the value you want to overwrite
/// - Returns: a function that'll return a new, updated source
public prefix func ^ <Root, Value>(kp: WritableKeyPath<Root, Value>)
-> (@escaping (Value) -> Value)
-> (Root) -> Root {
    return prop(kp)
}

public prefix func ^ <Root, Value>(kp: WritableKeyPath<Root, Value>)
-> (@escaping (inout Value) -> Void)
-> (inout Root) -> Void {
    return { update in
        { root in
            update(&root[keyPath: kp])
        }
    }
}
