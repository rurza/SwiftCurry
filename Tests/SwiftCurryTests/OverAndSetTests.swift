//
//  OverAndSetTests.swift
//  
//
//  Created by Adam Różyński on 22/04/2021.
//

@testable import SwiftCurry
import XCTest

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
    
}
