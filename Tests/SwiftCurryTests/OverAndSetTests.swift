//
//  OverAndSetTests.swift
//  
//
//  Created by Adam Różyński on 22/04/2021.
//

@testable import SwiftCurry
import XCTest

private func first<A, B, C>(_ f: @escaping (A) -> C) -> ((A, B)) -> (C, B) {
    return { pair in
        return (f(pair.0), pair.1)
    }
}

private func first<A, B>(_ f: @escaping (inout A) -> Void) -> (inout (A, B)) -> Void {
    return { pair in
        f(&pair.0)
    }
}

private func second<A, B, C>(_ f: @escaping (B) -> C) -> ((A, B)) -> (A, C) {
    return { pair in
        return (pair.0, f(pair.1))
    }
}

final class OverAndSetTests: XCTestCase {
    let user = User(
        favoriteFoods: [
            Food(name: "Tacos"),
            Food(name: "Nachos")
        ],
        location: Location(name: "Brooklyn"),
        name: "Blob"
    )
    
    func testSet() throws {
        let newLocation = "Czczew"
        let newUser = user |> set(prop(\.location.name), newLocation)
        XCTAssertEqual(newUser.location.name, newLocation)
    }
    
    func testOver() throws {
        let healthyUser = user
            |> over(prop(\.favoriteFoods) <<< map <<< prop(\.name)) { $0 + " salad"}
        for food in healthyUser.favoriteFoods {
            XCTAssertTrue(food.name.hasSuffix(" salad"))
        }
    }
    
    func testSetWithOperator() throws {
        let newLocation = "Czczew"
        let newUser = user |> set(^\.location.name, newLocation)
        XCTAssertEqual(newUser.location.name, newLocation)
    }
    
    func testOverWithOperator() throws {
        let healthyUser = user
            |> over(^\.favoriteFoods <<< map <<< ^\.name) { $0 + " salad"}
        for food in healthyUser.favoriteFoods {
            XCTAssertTrue(food.name.hasSuffix(" salad"))
        }
    }
    
    func testSetAndOverWithTuple() throws {
        let new = ("Hello, world!", 42)
            |> set(first, [1, 2, 3])
            |> over(second, String.init)
        XCTAssertEqual(new.0, [1, 2, 3])
        XCTAssertEqual(new.1, "42")
    }
    
    func testMutAndMverWithTuple() throws {
        let pair = ("Hello, world!", 42)
        let newPair = pair
            |> mut(first, "Dupa")
            <> mver(first, { $0 += "!" })
        XCTAssertEqual(newPair.0, "Dupa!")
        XCTAssertEqual(pair.0, "Hello, world!")
    }
}
